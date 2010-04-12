#!/bin/zsh
#-------------------------------------------------------
#   .zshrc - Overview
#-------------------------------------------------------
#   This file is the gateway to configuring the entire
#   dotfiles system for zsh.

# Autoload zsh color and terminal info support.
# Also figure out what OS we're on.
autoload colors zsh/terminfo
os=${OSTYPE//[0-9.]/}

# Go through dotfiles.d one file at a time and source everything.
for zshrc_snipplet in ~/.dotfiles.d/*[^~]; do
  source $zshrc_snipplet
done

# Some shorthand vars for colors in zsh.
if [[ "$terminfo[colors]" -ge 8 ]]; then
  colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
  eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
  eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
  (( count = $count + 1 ))
done

PR_NO_COLOR="%{$terminfo[sgr0]%}"

# Set up both the left and right prompt.
git_br='$(get_git_prompt_info "%b")'
git_dirty='$(get_git_prompt_info "%s")'
r_prompt="($PR_GREEN$git_br$PR_RED$git_dirty$PR_NO_COLOR)"

PS1="[$PR_BLUE%n$PR_NO_COLOR@$PR_GREEN%U%m%u$PR_NO_COLOR:$PR_RED%2c$PR_NO_COLOR]%(!.#.$) "
RPS1=$r_prompt
