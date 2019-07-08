# These are some utility functions to make my life a little more convienent

vim_fzf() {
    vim "$(searchfiles | fzf --preview 'bat --color always {1}')"
}
