call plug#begin("~/.local/share/vim-plugged")

"" Ctrl-P
" Plug 'ctrlpvim/ctrlp.vim'
" let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

"" Editorconfig
Plug 'editorconfig/editorconfig-vim'

"" Syntastic
Plug 'vim-syntastic/syntastic'
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_python_pylint_args = "-errors-only"

"" Airline
Plug 'vim-airline/vim-airline'

"" Autoformat
Plug 'Chiel92/vim-autoformat'

"" Fugitive (git wrapper)
Plug 'tpope/vim-fugitive'

"" Scala
"" Plug 'derekwyatt/vim-scala'
"" Plug 'ensime/ensime-vim', { 'do': ':UpdateRemotePlugins' }
"" let g:formatdef_scalafmt = "'scalafmt --stdin'"
"" let g:formatters_scala = ['scalafmt']
""autocmd FileType scala nmap <buffer> <Leader>t :EnType<CR>

"" Typescript
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'
autocmd FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>

"" fzf
Plug 'junegunn/fzf.vim'

call plug#end()
