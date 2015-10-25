#VIM Configuration

This repository is my configuration for vim stored on Github for convenience.

## Setup

This repository is meant to be cloned into `~/.vim`. A symbolic link (use `ln -s` on Linux or `mklink` on windows) must be made at ~/.vimrc pointing to ~/.vim.

## .vimrc configuration

To keep everything in one directory the .vimrc file is stored as vimrc.vim in this repository. This requires a symbolic link at ~/.vimrc pointing to the real .vimrc.

The current .vimrc is heavily based off [The Ultimate Vim Configuration on Github](https://github.com/amix/vimrc) however it has never been updated.

## Color Schemes

The `colors` folder contains all the custom color schemes. Since I suck at anything color or design related all of these probably came premade from [Vivify](http://bytefluent.com/vivify/).

Some color schemes require a 256-color terminal that detects properly. See http://vim.wikia.com/wiki/256_colors_setup_for_console_Vim for more information.

## Plugins

Plugins are managed with pathogen. All the plugins are submodules in the `bundle` directory. All repositories are currently udpated manually with git.

To download plugin repositories:
    git submodule update --init --recursive

To update plugin repositories:
    git submodule foreach git pull origin master
