#!/usr/bin/env bash

gitconfig_setup()
{
  name=$(git config --global user.name)
  email=$(git config --global user.email)
  
  cp ${PWD}/git/gitconfig ${HOME}/.gitconfig
  
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

# Links the specified file prepend a `.` to the name
link_file()
{
  if [[ -a ${HOME}/.${1} ]]; then
    echo "Removing old ~/.${1}..."
    rm ${HOME}/.${1}
  fi

  echo "Linking ~/.${1}..."
  ln -s ${PWD}/${1} ${HOME}/.${1}
}

# Main
link_file zshrc
link_file vimrc
link_file vim
link_file Xdefaults
link_file xinitrc
link_file xsession
link_file pentadactyl
link_file pentadactylrc

gitconfig_setup
