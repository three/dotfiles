if [[ ! -d "$QUORUM_ROOT" ]]; then
    echo "quorum.sh: Something is misconfigured!"
fi

export QR="$QUORUM_ROOT"

QUORUM_DJANGIO_FILES="QuorumMobile/app/constants/djangio_cache.json _custom_event_djangio_cache.json _djangio_cache.json _new_grassroots_djangio_cache.json _unsubscribed_djangio_cache.json"

quorum_activate() {
    source "$HOME/.virtualenvs/quorum/bin/activate"
}

quorum_init() {
    cd "$QUORUM_ROOT"
    quorum_activate
}

quorum_lasthotfixversion() {(
    cd "$QUORUM_ROOT"
    git branch -a | \
        grep '^\s*remotes\/origin\/hotfix\/[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*$' | \
        sed 's/^\s*remotes\/origin\/hotfix\///' | \
        sort -V | \
        tail -n1
)}

quorum_lasthotfixbranch() {
    echo "origin/hotfix/$(quorum_lasthotfixversion)"
}

quorum_devshell() {(
    quorum_init
    python manage.py shell_plus "$@"
)}

quorum_runserver() {(
    quorum_init
    python manage.py runserver "$@"
)}

quorum_parsedjangio() {(
    quorum_init
    git update-index --assume-unchanged ${=QUORUM_DJANGIO_FILES}
    python manage.py parse djangio
)}

quorum_resetdjangio() {(
    cd "$QUORUM_ROOT"
    git update-index --no-assume-unchanged ${=QUORUM_DJANGIO_FILES}
    git checkout HEAD -- ${=QUORUM_DJANGIO_FILES}
)}

quorum_jest() {(
    cd "$QUORUM_ROOT"
    "$(npm bin)/jest" --maxWorkers=4 --coverage "$@"
)}

quorum_localtest() {(
    quorum_init
    rm .coverage.*
    export LOCAL_PG=true
    coverage run manage.py test "$@" --color_logs
    LAST_COVERAGE_FILE="$(ls -a | grep 'coverage\..*' | sort | head -n1)"
    mv "$LAST_COVERAGE_FILE" .coverage
    coverage html
)}

quorum_pychecks() {(
    quorum_init
    LAST_HOTFIX_BRANCH="$(quorum_lasthotfixbranch)"
    COMMON_ANCESTOR="$(git merge-base HEAD $LAST_HOTFIX_BRANCH)"
    ALTERED_FILES="$(git diff --name-only $COMMON_ANCESTOR)"
    [[ -z "$ALTERED_FILES" ]] && (
        echo "No files to check!"
        return 0
    )
    echo "Files to check:"
    echo "$ALTERED_FILES" | xargs python tests/check.py
    return $?
)}

quorum_tmux() {
    tmux new-session -d "QUORUM_AUTOACTIVATE=true $SHELL" \; attach
}

quorum_cypress() {(
    cd "$QUORUM_ROOT"
    export cypress_baseUrl=http://127.0.0.1:8000
    "$(npm bin)/cypress" "$@"
)}

quorum_jestwithdebugger() {(
    cd "$QUORUM_ROOT"
    node --inspect-brk "$(npm bin)/jest" --runInBand "$@"
)}

alias qcd='pushd $QUORUM_ROOT'
alias qj='quorum_jest'
alias qt='quorum_localtest'
alias qlh='quorum_lasthotfixversion'
alias qhb='quorum_lasthotfixbranch'
alias qpc='quorum_pychecks'
alias q='quorum_tmux'

if [[ "$QUORUM_AUTOACTIVATE" = "true" ]]; then
    quorum_init
    export QUORUM_AUTOACTIVATE=false
fi
