"""""""""""""""""""""""
"    Rocky's .vimrc   "
" (C) 2010 Rocky Meza "
"""""""""""""""""""""""

"""" {{{ general

""" basic
set nocompatible
set shm=I

" filetype stuff
filetype on
filetype plugin on
filetype indent on

" for sup
au BufRead *-sup.*        set ft=mail


""" look
" theme
syntax enable
set number
colors zenburn

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
set ignorecase

" clear search
map <F3> <ESC>:let @/ = ''<RETURN>

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

" buffer management
map <F5> <ESC>:FufBuffer<RETURN>

" file opening
map <F8> <ESC>:FufFile **/<RETURN>
map <F9> <ESC>:NERDTreeToggle<RETURN>

" ctags
map <F12> <ESC>:TlistToggle<RETURN>

" for editing vimrc
nmap <Leader>s :source $MYVIMRC
nmap <Leader>v :e $MYVIMRC
nmap <Leader>r :exec ReloadAllSnippets()

" split view motions
map <C-l> <C-W>l
map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k

" tab bindings
imap <S-Tab> <ESC>v<<<ESC>i
vmap <Tab> >gv
vmap <S-Tab> <gv

" super tab
let g:SuperTabSetDefaultCompletionType='context'

"""" }}} general
