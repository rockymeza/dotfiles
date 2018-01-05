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

alias hr="heroku local:run"
alias hma="hr python manage.py"

alias fab="fy fab"

# Rails
alias dc="b tasmania && sudo /usr/local/bin/docker-compose"
alias ds="dc up -d"
alias dl="dc logs -t -f --tail 1"
alias fr="dc exec rails foreman run bundle exec"
alias frc="fr rails console"
alias djs="dc exec js"
