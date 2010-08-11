#!/usr/bin/env bash
#-------------------------------------------------------
#   Rakefile - Overview
#-------------------------------------------------------
#   This is the shell-based method to install dotfiles.
#   This does the exact same thing as the Rakefile, but
#   is primarily intended for those who do not have
#   access to Ruby on their system.

#--------------------------------------------------
#   Function to regenerate .gitconfig and place it
#   in the user's home directory
#--------------------------------------------------
gitconfig_setup()
{
  name=$(git config --global user.name)
  email=$(git config --global user.email)
  
  if [ -a ${HOME}/.gitconfig ]; then
    rm ${HOME}/.gitconfig
    cp ${PWD}/git/gitconfig ${HOME}/.gitconfig
  else
    cp ${PWD}/git/gitconfig ${HOME}/.gitconfig
  fi
  
  read -p "Git Name (leave blank to default to '${name}'): " new_name
  read -p "Git Email (leave blank to default to '${email}'): " new_email
  
  if [ -z "$new_name" ]; then
    git config --global user.name "${name}"
  else
    git config --global user.name "${new_name}"
  fi
  
  if [ -z "$new_email" ]; then
    git config --global user.email "${email}"
  else
    git config --global user.email "${new_email}"
  fi
  
  git config --global core.excludesfile $PWD/git/gitignore
}

#--------------------------------------------------
#   If the user simply runs `./install.sh`, display
#   the possible options
#--------------------------------------------------
help_message()
{
  echo "Usage: ./install.sh [option]"
  echo "Possible options: install, gc"
}

#--------------------------------------------------
#   Creates a symbolically linked "." version of a
#   file in the user's home directory
#--------------------------------------------------
link_file()
{
  if [[ -a ${HOME}/.${1} ]]; then
    echo "Removing old ~/.${1}..."
    rm ${HOME}/.${1}
  fi

  echo "Linking ~/.${1}..."
  ln -s ${PWD}/${1} ${HOME}/.${1}
}

#--------------------------------------------------
#   Main program
#--------------------------------------------------
link_file zshrc
link_file vimrc
link_file vim
link_file Xdefaults
link_file xinitrc
link_file xsession

gitconfig_setup
