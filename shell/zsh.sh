source $DOTFILES/shell/common.sh

export ZSH=$DOTFILES/shell/oh-my-zsh
export DISABLE_AUTO_UPDATE="true"

export ZSH_CUSTOM=$DOTFILES/shell/oh-my-zsh-custom

if [[ "$MYCONFIG_POWERLINE" == "true" ]]; then
    export ZSH_THEME="powerlevel9k"
    source powerlevel9k.sh
else
    export ZSH_THEME="clean"
fi

plugins=(git)
unsetopt AUTO_CD

source $ZSH/oh-my-zsh.sh

# Intead of loading NVM immediately (since it's rarely used), only load on
# first use. Note the definition of the nvm command will be overwritten by
# nvm.sh, so this is not actually recursive

export NVM_DIR=$DOTFILES/shell/nvm
nvm() {
    source $NVM_DIR/nvm.sh
    nvm "$@"
}
