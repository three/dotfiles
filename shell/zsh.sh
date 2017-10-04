source $DOTFILES/shell/common.sh

export ZSH=$DOTFILES/shell/oh-my-zsh
export ZSH_THEME="clean"
export DISABLE_AUTO_UPDATE="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh
