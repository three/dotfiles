source $DOTFILES/shell/common.sh

export ZSH=$DOTFILES/deps/oh-my-zsh
export DISABLE_AUTO_UPDATE="true"

export ZSH_CUSTOM="$DOTFILES/deps"

export POWERLEVEL9K_COLOR_SCHEME="light"

if [[ "$MYCONFIG_POWERLINE" == "true" ]]; then
    export ZSH_THEME="powerlevel9k/powerlevel9k"
    source $(dirname $0:A)/powerlevel9k.sh
else
    export ZSH_THEME="clean"
fi

#plugins=(git)
unsetopt AUTO_CD

source "$ZSH/oh-my-zsh.sh"

# Intead of loading NVM immediately (since it's rarely used), only load on
# first use. Note the definition of the nvm command will be overwritten by
# nvm.sh, so this is not actually recursive

export NVM_DIR="$DOTFILES/deps/nvm"
nvm() {
    source $NVM_DIR/nvm.sh || return 1
    nvm "$@"
}

# Init Quorum tools
if [[ -n "$QUORUM_ROOT" ]]; then
    source "$DOTFILES/shell/quorum.sh"
fi

# Misc Utilities
source "$DOTFILES/shell/utilities.sh"

# Aliases
source "$DOTFILES/shell/alias.sh"
