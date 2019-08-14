source $DOTFILES/deps/vim-plug/plug.vim

call plug#begin("~/.local/share/vim-plugged")

"" Editorconfig
""  Universal format for code formatting info

Plug 'editorconfig/editorconfig-vim'

"" Airline
""  Better status bar

Plug 'vim-airline/vim-airline'
let g:airline_powerline_fonts = 1

"" Fugitive
""  Git Wrapper

Plug 'tpope/vim-fugitive'

"" fzf
""  Fuzzy Search

Plug 'junegunn/fzf.vim'

"" LSP Client
""  Language Server Protocol generic client
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

let g:LanguageClient_serverCommands = {
    \ 'javascript': ['~/.yarn/bin/javascript-typescript-stdio'],
    \ 'typescript': ['~/.yarn/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['~/.yarn/bin/javascript-typescript-stdio'],
    \ 'typescript.tsx': ['~/.yarn/bin/javascript-typescript-stdio']
    \ }

nnoremap <silent> <Leader>t : <C-u>call LanguageClient#textDocument_hover()<CR>

"" Deoplete
""  Code Completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

"" Typescript
""  Requires neovim 0.4.0

" Syntax
Plug 'HerringtonDarkholme/yats.vim'

call plug#end()
