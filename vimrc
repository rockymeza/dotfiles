"""""""""""""""""""""""
"    Rocky's .vimrc   "
" (C) 2010 Rocky Meza "
"""""""""""""""""""""""

"""" {{{ general

""" basic
set nocompatible
set shm=I
set bs=2
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
set smartindent
set autoindent

" searching
set hlsearch
set incsearch

" clear search
nmap <F3> :noh<RETURN>

" line breaks
set showbreak=">"

" folding
set nofoldenable
set foldmethod=syntax

""" feel
" mouse
set mouse=a

"" mappings
" for saving files more quickly
cmap W w

" remap ZZ for safer saving
nmap ZZ :q<RETURN>

" file opening
map <Leader>o :CommandT<RETURN>

" for editing vimrc
nmap <Leader>s :source $MYVIMRC
nmap <Leader>v :e $MYVIMRC
nmap <Leader>r :exec ReloadAllSnippets()

" undo
set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000

" relativenumber
set relativenumber

" tab bindings
imap <S-Tab> <ESC>v<<<ESC>i
vmap <Tab> >gv
vmap <S-Tab> <gv

" vim tabs
nmap <Leader>t :tabnew<RETURN>

"""" }}} general
