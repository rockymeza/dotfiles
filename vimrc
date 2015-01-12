"""""""""""""""""""""""
"    Rocky's .vimrc   "
" (C) 2010 Rocky Meza "
"""""""""""""""""""""""

""" basic
set nocompatible
set shm=I
set bs=indent,eol,start
nmap <F1> <Esc>
imap <F1> <Esc>

" pathogen stuff (must be before filetype stuff)
filetype off
call pathogen#runtime_append_all_bundles()

" filetype stuff
filetype on
filetype plugin on
filetype indent on

" for sup
au BufRead *-sup.*        set ft=mail
au BufRead *.shpaml       so ~/.vim/ftplugin/shpaml.vim
au BufRead *.md           set ft=markdown


""" look
" theme
syntax enable
set number
colors zenburn|+

"statusline
set showmode
set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)\ %{fugitive#statusline()}
set showcmd

" tabs
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent

" searching
set hlsearch
set incsearch

" line breaks
set showbreak=">"

" folding
set foldmethod=marker

""" feel
" mouse
set mouse=a

"" mappings
" for saving files more quickly
cmap W w

" remap ZZ for safer saving
nmap ZZ :q<RETURN>

" for editing vimrc
nmap <Leader>s :source $MYVIMRC
nmap <Leader>v :e $MYVIMRC
nmap <Leader>r :exec ReloadAllSnippets()

" undo
set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000

" tab bindings
imap <S-Tab> <ESC>v<<<ESC>i
vmap <Tab> >gv
vmap <S-Tab> <gv

" ack.vim
let g:ackprg="ack-grep -H --nocolor --nogroup --column"
map <Leader>a :Ack

" wildmenu
set wildmenu
set wildignore=node_modules,*.old,*.swo,*.swp,*.pyc,build

" ctrlp
nmap <Leader>t :CtrlP<Enter>
nmap <Leader>c :CtrlPTag<Enter>
nmap <Leader>b :CtrlPBuffer<Enter>
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:50'
let g:ctrlp_clear_cache_on_exit = 0
