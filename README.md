#VIM Configuration

This repository is my configuration for vim stored on Github for convenience.

## Setup

To use this setup this repository must be cloned into the proper vim folder. On Linux this will be `~/.vim`. On Windows it will be `%HOME%\vimfiles`. After the repo is cloned the plugins must also be pulled for them to work correctly (see plugins).

## .vimrc configuration

To keep everything in one place all files should be placed in the same folder. See `:help vimrc` in vim to see what the defaults are.

The current .vimrc is heavily based off [The Ultimate Vim Configuration on Github](https://github.com/amix/vimrc) although it has never been updated from that source.

## Color Schemes

The `colors` folder contains all non-default themes for use with this setup. Most themes should contain a header saying where they originally came from. See [Vivify](http://bytefluent.com/vivify/) for more themes.

Some color schemes require a 256-color terminal that detects properly. See http://vim.wikia.com/wiki/256_colors_setup_for_console_Vim for more information.

## Plugins

Plugins are managed with pathogen. All the plugins are submodules in the `bundle` directory. All repositories are currently udpated manually with git.

To download plugin repositories:

    git submodule update --init --recursive

To update plugin repositories:

    git submodule foreach git pull origin master
