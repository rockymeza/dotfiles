"""""""""""""""""""""""
"    Rocky's .vimrc   "
" (C) 2010 Rocky Meza "
"""""""""""""""""""""""

""" basic
set nocompatible
set bs=indent,eol,start

" vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
Plug 'GutenYe/json5.vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'airblade/vim-gitgutter'
Plug 'chase/vim-ansible-yaml'
Plug 'craigemery/vim-autotag'
Plug 'editorconfig/editorconfig-vim'
Plug 'gabrielelana/vim-markdown'
Plug 'garbas/vim-snipmate'
Plug 'hynek/vim-python-pep8-indent'
Plug 'ivalkeen/vim-simpledb'
Plug 'jnurmine/Zenburn'
Plug 'junegunn/fzf.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'mgedmin/python-imports.vim'
Plug 'mitsuhiko/vim-jinja'
Plug 'mtscout6/syntastic-local-eslint.vim'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'rust-lang/rust.vim'
Plug 'tomtom/tcomment_vim'
Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-ruby/vim-ruby'
Plug 'w0rp/ale'
call plug#end()

" theme
set number
colors zenburn|+

" tabs
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent

set hlsearch
set incsearch

" mouse
set mouse=a

" fat fingers
nmap <F1> <Esc>
imap <F1> <Esc>
cmap W w

" undo
set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000

" wildmenu
set wildmenu
set wildignore=venv,node_modules,*.old,*.swo,*.swp,*.pyc,solr

" FZF
nmap <Leader>t :Files<Enter>
nmap <Leader>c :Tags<Enter>
nmap <Leader>b :Buffers<Enter>

let g:fzf_history_dir = '~/.local/share/fzf-history'

function! Ripgrep(q)
  call fzf#vim#grep(
        \ 'rg --column --line-number --no-heading --color=always '.a:q,
        \ 1,
        \ fzf#vim#with_preview('right:50%:hidden', '?'))
endfunction

command! -bang -nargs=* Rg
  \ call Ripgrep(<q-args>)

" rust.vim
let g:rustfmt_autosave = 1

" \\ to search for the current word in the entire project
nnoremap <Leader><Leader> :call Ripgrep(expand('<cword>'))<Enter>

" haml-coffee
autocmd BufNewFile,BufRead *.hamlc setf haml

" ALE
let g:ale_linters = {
\   'javascript': ['eslint', 'flow-language-server'],
\}

let g:ale_fixers = {
\   'javascript': ['eslint', 'prettier'],
\}

nnoremap <silent> K <Plug>(ale_hover)
nnoremap <silent> gd <Plug>(ale_go_to_definition)
nnoremap <silent> gf <Plug>(ale_fix)
nmap <silent> <C-k> <Plug>(ale_previous)
nmap <silent> <C-j> <Plug>(ale_next)

" asyncomplete

" Use ALE's function for asyncomplete defaults
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#ale#get_source_options({
    \ 'priority': 10,
    \ }))
