# Dotfiles

This repository contains my configuration for various tools. This README serves as documentation for my future self.

## Submodules

**Pull all Submodules**

    git submodule update --init --recursive

**Update all Submodules**

    git submodule foreach git pull origin master

## Colors

I try to configure terminal programs to be compatible with and without color-supporting terminals. If a terminal does not correctly report it supports color, color will not work.

PuTTY can be configured under `Connection -> Data -> Terminal-type string` with the value `xterm-256color` to accurately report its color support.

## Vim

Vim config is stored in `vim/`.

```
Linux   vim     $HOME/vim
Linux   neovim  $HOME/.config/neovim
Windows vim     %HOME%\vimfiles

Other   (See :help vimrc)
```

Vimrc on https://github.com/amix/vimrc

Many colorschemes are from or created with http://bytefluent.com/vivify/

## Shells

**ZSH w/ Oh My Zsh**

```
export DOTFILES=$HOME/dotfiles
source $DOTFILES/shell/zsh.sh
```

**Bash**

```
export DOTFILES=$HOME/dotfiles
source $DOTFILES/shell/bash.sh
```

# Copyright

Many parts of this repository are based on the work of others and have licenses attached to them. For everything that does not already have a license attached (original work by myself), I waive all copyright.
