source $DOTFILES/shell/common.sh

export ZSH=$DOTFILES/shell/oh-my-zsh
export DISABLE_AUTO_UPDATE="true"

if [[ "$MYCONFIG_POWERLINE" == "true" ]]; then
    export ZSH_THEME="agnoster"
else
    export ZSH_THEME="clean"
fi

plugins=(git)

source $ZSH/oh-my-zsh.sh
