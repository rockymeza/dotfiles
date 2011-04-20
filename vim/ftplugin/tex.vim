"""""""""""""""""""""""
"    Rocky's .vimrc   "
" (C) 2010 Rocky Meza "
"""""""""""""""""""""""

"""" {{{ tex
" feel
set spell

" pdflatex
map <Leader>l :! xelatex %<RETURN>
map <Leader>b :! basename % \| sed -e 's/\.tex$//' \| xargs bibtex<RETURN>

" tricks up my sleeve
nmap <Leader>e F`s\emph{<Esc>f'r}
nmap <Leader>q T{cF\`<Esc>f}r'

"""" }}} tex
