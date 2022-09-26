source $DOTFILES/deps/vim-plug/plug.vim

" Neovim only

call plug#begin("~/.local/share/vim-plugged")
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'HerringtonDarkholme/yats.vim'
call plug#end()

set omnifunc=ale#completion#OmniFunc
let g:airline_powerline_fonts = 1
nnoremap <silent> <buffer> <Leader>t : <C-u>ALEHover<CR>
call deoplete#custom#option('sources', {
    \ '_': ['ale'],
    \})
