edit_fzf_git() {(
    cd "$(git rev-parse --show-toplevel || return $?)"
    FILE_TO_EDIT="$(git ls-files -oc --exclude-standard | fzf --preview 'bat --color always {1}')"
    [[ ! $? = 0 ]] && return $?
    "$EDITOR" "$FILE_TO_EDIT"
)}
