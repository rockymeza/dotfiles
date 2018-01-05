"""""""""""""""""""""""
"    Rocky's .vimrc   "
" (C) 2010 Rocky Meza "
"""""""""""""""""""""""

""" basic
set nocompatible
set bs=indent,eol,start

" pathogen stuff (must be before filetype stuff)
filetype off

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'AutoTag'
Plugin 'GutenYe/json5.vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'MaxMEllon/vim-jsx-pretty'
Plugin 'airblade/vim-gitgutter'
Plugin 'chase/vim-ansible-yaml'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'garbas/vim-snipmate'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'ivalkeen/vim-simpledb'
Plugin 'jnurmine/Zenburn'
Plugin 'jremmen/vim-ripgrep'
Plugin 'kchmck/vim-coffee-script'
Plugin 'mattn/emmet-vim'
Plugin 'mgedmin/python-imports.vim'
Plugin 'mitsuhiko/vim-jinja'
Plugin 'mtscout6/syntastic-local-eslint.vim'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'rust-lang/rust.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'tomtom/tlib_vim'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-ruby/vim-ruby'
Plugin 'w0rp/ale'

call vundle#end()

" filetype stuff
filetype indent plugin on


" theme
syntax enable
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
