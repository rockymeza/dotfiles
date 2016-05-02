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

Plugin 'gmarik/Vundle.vim'

Plugin 'AutoTag'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'chase/vim-ansible-yaml'
Plugin 'garbas/vim-snipmate'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mgedmin/python-imports.vim'
Plugin 'mileszs/ack.vim'
Plugin 'mitsuhiko/vim-jinja'
Plugin 'mxw/vim-jsx'
Plugin 'pangloss/vim-javascript'
Plugin 'rust-lang/rust.vim'
Plugin 'scrooloose/Syntastic'
Plugin 'tomtom/tcomment_vim'
Plugin 'tomtom/tlib_vim'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-surround'

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
set wildignore=node_modules,*.old,*.swo,*.swp,*.pyc,build,solr

" ctrlp
nmap <Leader>t :CtrlP<Enter>
nmap <Leader>c :CtrlPTag<Enter>
nmap <Leader>b :CtrlPBuffer<Enter>
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:50'
let g:ctrlp_clear_cache_on_exit = 0

" make Ack use ag
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
let g:ack_use_dispatch = 1

" \\ to search for the current word in the entire project
nnoremap <Leader><Leader> :let @/ = expand('<cword>')\|AckFromSearch<Enter>
