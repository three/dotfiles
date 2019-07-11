if [[ ! -d "$QUORUM_ROOT" ]]; then
    echo "quorum.sh: Something is misconfigured!"
fi

export QR="$QUORUM_ROOT"

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
    python manage.py parse djangio
)}

quorum_jest() {(
    cd "$QUORUM_ROOT"
    "$(npm bin)/jest" "$@"
)}

quorum_localtest() {(
    quorum_init
    export LOCAL_PG=true
    python manage.py test "$@"
)}

quorum_pychecks() {(
    quorum_init
    python tests/check.py
    return $?
)}

quorum_tmux() {(
    cd "$QUORUM_ROOT"
    tmux -c "QUORUM_AUTOACTIVATE=true zsh"
)}

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
alias qd='git diff -- '"'"':(exclude)*.json'"'"
alias qlh='quorum_lasthotfixversion'
alias qhb='quorum_lasthotfixbranch'
alias qtm='quorum_tmux'
alias qpc='quorum_pychecks'

[[ "$QUORUM_AUTOACTIVATE" = "true" ]] && quorum_activate
