#!/bin/sh

alias rmpyc="find . -name '*.pyc' -delete"
alias rmswp="find . -name '*.swp' -delete"

alias vim="vimx"

alias ssh="TERM=xterm-color ssh"

# TODO: This outputs an extra line when used in vim
alias ppsql="sqlformat --reindent --keywords upper -"

# Django
alias ma="fy python manage.py"
alias mars="ma runserver 0.0.0.0:8000"
alias marsp="ma runserver_plus 0.0.0.0:8000"
alias mam="ma migrate"
alias mash="ma shell_plus"

alias fab="fy fab"
