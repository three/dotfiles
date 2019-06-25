if [[ -n "$QUORUM_ROOT" ]]; then
    export QR="$QUORUM_ROOT"

    quorum_activate() {
        source "$HOME/.virtualenvs/quorum/bin/activate"
    }

    quorum_lasthotfixversion() {
        (
            cd "$QUORUM_ROOT"
            git branch -a | \
                grep '^\s*remotes\/origin\/hotfix\/[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*$' | \
                sed 's/^\s*remotes\/origin\/hotfix\///' | \
                sort -V |\
                tail -n1
        )
    }
    
    quorum_lasthotfixbranch() {
        echo "origin/hotfix/$(quorum_lasthotfixversion)"
    }

    quorum_launchdevshell() {
        (
            cd "$QUORUM_ROOT"
            quorum_activate
            python manage.py shell_plus
        )
    }

    quorum_runserver() {
        (
            cd "$QUORUM_ROOT"
            quorum_activate
            python manage.py runserver
        )
    }

    quorum_parsedjangio() {
        (
            cd "$QUORUM_ROOT"
            quorum_activate
            python manage.py parse djangio
        )
    }

    quorum_jest() {
        (
            cd "$QUORUM_ROOT"
            "$(npm bin)/jest" "$@"
        )
    }

    quorum_localtest() {
        (
            cd "$QUORUM_ROOT"
            quorum_activate
            export LOCAL_PG=true
            python manage.py test "$@"
        )
    }

    quorum_pychecks() {
        (
            cd "$QUORUM_ROOT"
            quorum_activate
            python tests/check.py
            return $?
        )
    }

    # Change directory to root, adding previous dir to stack
    alias qcd='pushd $QUORUM_ROOT'
    # Run jest tests from root
    alias qjt='quorum_jest'
fi
