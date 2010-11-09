#!/usr/bin/env zsh
#-------------------------------------------------------
#   zshrc - Overview
#-------------------------------------------------------
#   This file is the gateway to configuring the entire
#   dotfiles system for zsh.  In terms of base aliases,
#   functions, environment exports, etc., this is the
#   only file that needs to be symlinked to one's home
#   directory.  Beyond that, the remainder is contained
#   wherever the Git repository was cloned.

#--------------------------------------------------
#   Determines operating system, root directory
#   of dotfiles, and autoloads several basic zsh
#   options
#--------------------------------------------------
dotfile_dir=$(dirname $(readlink "${HOME}/.zshrc"))
typeset -U path manpath fpath
autoload colors zsh/terminfo
autoload -U compinit
autoload run-help
compinit

#-------------------------------------------------
#   Set the PATH
#-------------------------------------------------
export PATH=$HOME/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$dotfile_dir/bin:.:/home/rocky/source/shoes/dist

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

bindkey -e
