source $DOTFILES/deps/vim-plug/plug.vim

" Neovim only

call plug#begin("~/.local/share/vim-plugged")
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" I'd preferably use
Plug 'HerringtonDarkholme/yats.vim'
" for highlighting and indentation but I keep running into a problem where depending on if
" syntax=typescript or typescript.vim, either highlighting or indentation stops working.
" Indentation with this isn't great, but at least I don't have to choose.
"Plug 'leafgarland/typescript-vim'
call plug#end()


set omnifunc=ale#completion#OmniFunc
let g:airline_powerline_fonts = 1
nnoremap <silent> <buffer> <Leader>t : <C-u>ALEHover<CR>
call deoplete#custom#option('sources', {
    \ '_': ['ale'],
    \})

let b:ale_linters = {
    \ 'typescriptreact': 'typescript',
    \ 'c': 'clangtidy'
    \ }

augroup typescript_filetype
    autocmd!
    "autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact
    "autocmd BufNewFile,BufRead *.tsx set syntax=typescript
    "autocmd BufNewFile,BufRead *.ts set filetype=typescript
    autocmd BufNewFile,BufRead *.tsx setlocal syntax=typescript
augroup END

augroup clang_filetype
    autocmd!
    autocmd BufNewFile,BufRead *.c let b:ale_linters=['clangtidy']
    autocmd BufNewFile,BufRead *.h let b:ale_linters=['clangtidy']
augroup END
