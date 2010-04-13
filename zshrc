#!/bin/zsh
#-------------------------------------------------------
#   .zshrc - Overview
#-------------------------------------------------------
#   This file is the gateway to configuring the entire
#   dotfiles system for zsh.

# Determine operating system
os=${OSTYPE//[0-9.]/}

# Determine root directory of dotfiles
dotfile_dir=$(dirname $(readlink "${HOME}/.zshrc"))

# Autoload zsh color and terminal info support.
autoload colors zsh/terminfo

# Go through dotfiles.d one file at a time and source everything
# at the first level
for snippet in ${dotfile_dir}/dotfiles.d/*[^~]; do
  source $snippet
done

# Some shorthand vars for colors in zsh
if [[ "$terminfo[colors]" -ge 8 ]]; then
  colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
  eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
  eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
  (( count = $count + 1 ))
done

# Shorthand var for "no color"
PR_NO_COLOR="%{$terminfo[sgr0]%}"

# Determine the git branch and status
git_br='$(get_git_prompt_info "%b")'
git_state='$(get_git_prompt_info "%s")'

# Set up both the left and right prompt
PS1="[$PR_BLUE%n$PR_NO_COLOR@$PR_GREEN%U%m%u$PR_NO_COLOR:$PR_RED%2c$PR_NO_COLOR]%(!.#.$) "
RPS1="($PR_GREEN$git_br$PR_RED$git_state$PR_NO_COLOR)"
