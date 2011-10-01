"""""""""""""""""""""""
"    Rocky's .vimrc   "
" (C) 2010 Rocky Meza "
"""""""""""""""""""""""

" feel
set spell

imap govt government
imap natl national
imap intl international

" pdflatex
map <Leader>x :! xelatex %<RETURN>
map <Leader>l :! pdflatex %<RETURN>
map <Leader>b :! basename % \| sed -e 's/\.tex$//' \| xargs bibtex<RETURN>

" tricks up my sleeve
nmap <Leader>e F`s\emph{<Esc>f'r}
nmap <Leader>q T{cF\`<Esc>f}r'
" color
vmap <Leader>c <Esc>`<i\textbf{\color{red} <Esc>`>20la}<Esc>
" clean up from import
nmap <Leader>c :%s/’/'/g<RETURN>:%s/“/``/g<RETURN>:%s/”/''/g<RETURN>
