edit_fzf_git() {(
    VIM_TOPLEVEL_DIR="$(git rev-parse --show-toplevel)"
    [[ ! $? = 0 ]] && return $?
    cd "$VIM_TOPLEVEL_DIR"
    FILE_TO_EDIT="$(git ls-files -oc --exclude-standard | fzf --preview 'bat --color always {1}')"
    [[ ! $? = 0 ]] && return $?
    "$EDITOR" "$FILE_TO_EDIT"
)}

cd_fzf() {
    DIR_TO_CD="$(find -type d | fzf)"
    [[ ! $? = 0 ]] && return $?
    cd "$DIR_TO_CD"
}
