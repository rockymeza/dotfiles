# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=-1
HISTFILESIZE=-1

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;35m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
fi

# Alias definitions.
alias ll='ls -l'
alias tags="ctags '--exclude=*.min.*' --exclude='*/CACHE/*' -R"

alias rmpyc="find . -name '*.pyc' -delete"
alias rmswp="find . -name '*.swp' -delete"

alias vim="vimx"

alias ssh="TERM=xterm-color ssh"

alias ppsql="sqlformat --reindent --keywords upper -"

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


DOTFILES_LOCATION=$HOME/projects/dotfiles

export EDITOR='vimx'
export PYTHONSTARTUP=$HOME/.pystartup

. $DOTFILES_LOCATION/modules/b/b.sh
. $DOTFILES_LOCATION/modules/b/b_completion.sh

for f in $DOTFILES_LOCATION/autoload/*; do
  . $f
done

if [ -f ~/autoload ] && [ "$(ls -A ~/autoload)" ]; then
  for f in ~/autoload/*; do
    . $f
  done
fi

. "$DOTFILES_LOCATION/paths"

export FZF_DEFAULT_COMMAND="rg --files --hidden --iglob '!.git'"

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /home/rocky/.config/yarn/global/node_modules/tabtab/.completions/serverless.bash ] && . /home/rocky/.config/yarn/global/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /home/rocky/.config/yarn/global/node_modules/tabtab/.completions/sls.bash ] && . /home/rocky/.config/yarn/global/node_modules/tabtab/.completions/sls.bash
