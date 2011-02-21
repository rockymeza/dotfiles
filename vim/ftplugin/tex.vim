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

"""" }}} tex
