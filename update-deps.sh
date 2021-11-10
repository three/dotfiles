#!/usr/bin/env bash
set -e
set -u

DEPS_DIRECTORY="$DOTFILES/deps"

update_git_repo() {
    (
        echo "Update $1..."
        cd "$DEPS_DIRECTORY"
        [[ -d "./$1" ]] || git clone --depth=1 "$2" "$1"
        cd "./$1"
        git pull
        git submodule update --init --recursive
    )
}

[[ -d "$DEPS_DIRECTORY" ]] || mkdir "$DEPS_DIRECTORY"

update_git_repo nvm https://github.com/nvm-sh/nvm.git
update_git_repo oh-my-zsh https://github.com/robbyrussell/oh-my-zsh.git
update_git_repo powerlevel9k https://github.com/bhilburn/powerlevel9k.git
update_git_repo vim-plug https://github.com/junegunn/vim-plug.git
update_git_repo zsh-histdb https://github.com/larkery/zsh-histdb
