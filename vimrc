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
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'airblade/vim-gitgutter'
Plug 'burnettk/vim-angular'
Plug 'chase/vim-ansible-yaml'
Plug 'craigemery/vim-autotag'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'garbas/vim-snipmate'
Plug 'hynek/vim-python-pep8-indent'
Plug 'ivalkeen/vim-simpledb'
Plug 'jelera/vim-javascript-syntax'
Plug 'jnurmine/Zenburn'
Plug 'jremmen/vim-ripgrep'
Plug 'kchmck/vim-coffee-script'
Plug 'mattn/emmet-vim'
Plug 'mgedmin/python-imports.vim'
Plug 'mitsuhiko/vim-jinja'
Plug 'mtscout6/syntastic-local-eslint.vim'
Plug 'mxw/vim-jsx'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'pangloss/vim-javascript'
Plug 'rust-lang/rust.vim'
Plug 'tomtom/tcomment_vim'
Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-markdown'
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

" ctrlp
nmap <Leader>t :CtrlP<Enter>
nmap <Leader>c :CtrlPTag<Enter>
nmap <Leader>b :CtrlPBuffer<Enter>
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:50'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_files = 0

" make Ack use ag
let g:rg_derive_root = 1

" rust.vim
let g:rustfmt_autosave = 1

" \\ to search for the current word in the entire project
nnoremap <Leader><Leader> :Rg<Enter>

" haml-coffee
autocmd BufNewFile,BufRead *.hamlc setf haml

" Map movement through errors without wrapping.
nmap <silent> <C-k> <Plug>(ale_previous)
nmap <silent> <C-j> <Plug>(ale_next)

set conceallevel=1
