source "$DOTFILES/shell/common.sh"

export ZSH="$DOTFILES/deps/oh-my-zsh"
export DISABLE_AUTO_UPDATE="true"

export ZSH_CUSTOM="$DOTFILES/deps"

if [[ -z "$POWERLEVEL9K_COLOR_SCHEME" ]]; then
    export POWERLEVEL9K_COLOR_SCHEME="light"
fi

if [[ "$MYCONFIG_POWERLINE" == "true" ]]; then
    export ZSH_THEME="powerlevel9k/powerlevel9k"
    source $(dirname $0:A)/powerlevel9k.sh
else
    export ZSH_THEME="clean"
fi

plugins=( )
unsetopt AUTO_CD

source "$ZSH/oh-my-zsh.sh"

autoload -U compinit && compinit

PROMPT='%{$fg[$NCOLOR]%}%B%n%b@%m%{$reset_color%}:%{$fg[blue]%}%B%c/%b%{$reset_color%} $(git_prompt_info)%(!.#.$) '

# Fedora implements this annoying package auto-installer,
# just override it completely
command_not_found_handler() {
    printf 'zsh: %scommand not found\n' "${1:+$1: }" >&2
}

# Intead of loading NVM immediately (since it's rarely used), only load on
# first use. Note the definition of the nvm command will be overwritten by
# nvm.sh, so this is not actually recursive
export NVM_DIR="$DOTFILES/deps/nvm"
nvm() {
    source $NVM_DIR/nvm.sh || return 1
    nvm "$@"
}

# Commit note
cnote() {
    git reset
    git commit --allow-empty "[WIP] $1"
}

# Quick Commit
gsave() {
    local DES
    DES="[$(git symbolic-ref --short HEAD | egrep -o '[A-Za-z0-9_-]+$' || echo SAVE)]"
    if [[ $# -gt 0 ]]; then
        DES="$DES $@"
    fi
    git commit -am "$DES"
    return $?
}

# Misc Utilities
source "$DOTFILES/shell/utilities.sh"

# Aliases
source "$DOTFILES/shell/alias.sh"

# K
source "$DOTFILES/shell/k.zsh"

# Zsh-histdb
if [[ "$(uname)" = Darwin ]]; then
    HISTDB_TABULATE_CMD=(sed -e $'s/\x1f/\t/g')
fi
source "$DOTFILES/deps/zsh-histdb/sqlite-history.zsh"
autoload -Uz add-zsh-hook

# zsh-autosuggest
if [[ "$MYCONFIG_ZSHAUTOSUGGEST" ]]; then
    source "$DOTFILES/deps/zsh-autosuggestions/zsh-autosuggestions.zsh"
    _zsh_autosuggest_strategy_histdb_top_here() {
        local query="select commands.argv from
    history left join commands on history.command_id = commands.rowid
    left join places on history.place_id = places.rowid
    where places.dir LIKE '$(sql_escape $PWD)%'
    and commands.argv LIKE '$(sql_escape $1)%'
    group by commands.argv order by count(*) desc limit 1"
        suggestion=$(_histdb_query "$query")
    }
    ZSH_AUTOSUGGEST_STRATEGY=histdb_top_here
fi
