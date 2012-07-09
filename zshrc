#!/usr/bin/env zsh
dotfile_dir=$(dirname $(readlink "${HOME}/.zshrc"))
typeset -U path manpath fpath
autoload colors zsh/terminfo

# completion stuff
fpath=($dotfile_dir/zsh/completion_files/ $fpath)
autoload -U compinit

autoload run-help
compinit

#-------------------------------------------------
#   Set the PATH
#-------------------------------------------------
export PATH=$HOME/bin:$HOME/local/bin:$dotfile_dir/bin:.:$HOME/.cabal/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/var/lib/gems/1.8/bin
export EDITOR='vim'
export PYTHONSTARTUP=$dotfile_dir/pystartup


#--------------------------------------------------
#   Sets shorthand variables for some common colors
#   that we're going to use
#--------------------------------------------------
[[ "$terminfo[colors]" -ge 8 ]] && colors
PR_NO_COLOR="%{$terminfo[sgr0]%}"
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
  eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
  eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
  (( count = $count + 1 ))
done

#--------------------------------------------------
#   Source some stuff
#--------------------------------------------------
for snippet in ${dotfile_dir}/zsh/*[^~]; do
  source $snippet
done
#
# Load RVM into a shell session *as a function*
[[ -s "/home/rocky/.rvm/scripts/rvm" ]] && source "/home/rocky/.rvm/scripts/rvm"

#--------------------------------------------------
#   Set the title
#--------------------------------------------------
echo -n "\033]0;${USER}@${HOST} - ${PWD}\007"

#--------------------------------------------------
#   Sets up both the left 
#   and right prompt
#--------------------------------------------------
PROMPT="$PR_LIGHT_MAGENTA%~$PR_NO_COLOR$ "
RPROMPT='$(prompt_git_info)'


#--------------------------------------------------
#  For local customization
#--------------------------------------------------
if [[ -f $HOME/.aliases ]]; then
  source $HOME/.aliases
fi

# this was never useful
stty -ixon

bindkey -e
