edit_fzf_git() {(
    cd "$(git rev-parse --show-toplevel || return $?)"
    "$EDITOR" "$(git ls-files -oc --exclude-standard | fzf --preview 'bat --color always {1}')"
)}
