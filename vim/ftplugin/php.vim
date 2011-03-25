"""""""""""""""""""""""
"    Rocky's .vimrc   "
" (C) 2010 Rocky Meza "
"""""""""""""""""""""""

" {{{ php

"" code completion
set dictionary-=/home/rocky/.vim/dictionary/php_funclist.txt dictionary+=/home/rocky/.vim/dictionary/php_funclist.txt
set complete-=k complete+=k

"" php lint
nmap <Leader>l :! php -l %

"php property notation to array notation
nmap g[ F-2s['ea']
"array notation to property
nmap g> F[2s->f'2x

" decode a single base64 block
nmap g"1 vap!base64 -d
" decode everything that looks like a base64 block
nmap g"2 :g/[0-9A-z/+=]\{76}/norm g"1
" strip trailing line ending crud
nmap gc mp:g/\r$/s``
" convert email logs
nmap g6 gcmpggg"2`p

" }}} php
