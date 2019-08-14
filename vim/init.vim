"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Eric's Personal vimrc
" Maintainer: Eric Roberts <eric@threedot14.com>
" License: MIT
"
" This file is licensed under MIT. The latest version and a
" copy of the license can be found at
"   https://github.com/threedot14/dotfiles
"
" Inspired by the Ultimate vimrc:
"   https://github.com/amix/vimrc
"
" Although I strive to make my vim configuration compatible
" with both vim and neovim, I primarily use neovim.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic Configuration

set history=700
filetype plugin on
filetype indent on
set encoding=utf8

" Better autocomplete menu
set wildmenu
set wildignore=*.o,*~,*.pyc

" Number of vertical lines to maintain visible above and below cursor
set so=7

" Hide buffers when they're abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Don't redraw executing macros
set lazyredraw 

" Disable bell
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Line numbers
set number

" Use Unix as the standard file type
set ffs=unix,dos,mac

" File backups
set nobackup
set nowb
set noswapfile

" Indentation
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Text wrapping
set lbr
set tw=500

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Extra Keyboard Mappings

let mapleader = ","
let g:mapleader = ","

" Use hjkl to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Remap VIM 0 to first non-blank character
map 0 ^

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Fuzzy Search
nmap <c-p> :call fzf#run({'sink': 'e', 'source': 'listsearchfiles'})<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search

set ignorecase
set smartcase
set hlsearch
set incsearch 
set magic

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Look and color

set showmatch 
set mat=2

" Syntax highlighting
syntax enable 

au BufRead,BufNewFile *.ts setfiletype typescript

set background=dark
let g:rehash256 = 1
colorscheme molokai

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
    set guifont=Fixedsys:h10
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Miscellaneous

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

" Don't Show line numbers in terminal (neovim only)
function! SetNoNumberNoRelativeNumber()
    set norelativenumber
    set nonumber
endfunc

if has('nvim')
    autocmd TermOpen * :call SetNoNumberNoRelativeNumber()
end

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mouse

" https://superuser.com/questions/549930/cant-resize-vim-splits-inside-tmux
set mouse+=a
if &term =~ '^screen'
    set ttymouse=xterm2
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Other config files

if filereadable(expand($DOTFILES."/vim/config.vim"))
    runtime ./config.vim
else
    runtime plugins.vim
endif
