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
set ignorecase

" clear search
map <F3> <ESC>:noh<RETURN>

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

" buffer management
map <F5> <ESC>:FufBuffer<RETURN>

" file opening
map <F8> <ESC>:CommandT<RETURN>
map <F9> <ESC>:NERDTreeToggle<RETURN>

" ctags
map <F12> <ESC>:TlistToggle<RETURN>

" for editing vimrc
nmap <Leader>s :source $MYVIMRC
nmap <Leader>v :e $MYVIMRC
nmap <Leader>r :exec ReloadAllSnippets()

" split view motions
nmap <C-l> <C-W>l
nmap <C-h> <C-W>h
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <Leader>= <C-W>+
nmap <Leader>- <C-W>-

" tab bindings
imap <S-Tab> <ESC>v<<<ESC>i
vmap <Tab> >gv
vmap <S-Tab> <gv

" vim tabs
nmap <Leader>t :tabnew<RETURN>

" super tab
let g:SuperTabSetDefaultCompletionType='context'

"""" }}} general
