# Dotfiles

This repository contains my configuration for various tools. This README serves mostly as documentation for my future self, but also contains information for others interested in my configuration.

## Submodules

**Pull all Submodules**

    git submodule update --init --recursive

**Update all Submodules**

    git submodule foreach git pull origin master

## Colors

I try to configure terminal programs to be compatible with and without color-supporting terminals. If a terminal does not correctly report it supports color, color will not work.

PuTTY can be configured under `Connection -> Data -> Terminal-type string` with the value `putty-256color` to accurately report its color support.

## Vim

Vim config is stored in `vim`.

```
Linux   vim     $HOME/.vim
Linux   neovim  $HOME/.config/neovim
Windows vim     %HOME%\vimfiles

Other   (See :help vimrc)
```

My vimrc is based on https://github.com/amix/vimrc

Many colorschemes are from or created with http://bytefluent.com/vivify/

## Shells

**ZSH w/ Oh My Zsh**

```
export DOTFILES=$HOME/dotfiles
source $DOTFILES/shell/zsh.sh
```

**ZSH w/ Oh My Zsh and Powerline-compatible font**

```
export DOTFILES=$HOME/dotfiles
export MYCONFIG_POWERLINE=true
source $DOTFILES/shell/zsh.sh
```

**Bash**

```
export DOTFILES=$HOME/dotfiles
source $DOTFILES/shell/bash.sh
```

## Guides

The `guides` directory contains things like setup instructions, setup scripts and other random bits of information I sometimes find useful or want to reference. I make no promise anything there is accurate, will work or even be legible, but if you have questions about something in there feel free to message me.

# License

Many parts of this repository are based on the work of others and have licenses attached to them, for instance at the top of the file. The submodules linked to by this project may also have licenses attached to them. For everything that does not already have a license attached, you have permission to use, copy, modify or distribute without permission, but with no warranties (see https://creativecommons.org/publicdomain/zero/1.0/legalcode).
