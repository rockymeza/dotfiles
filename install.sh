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
  src=$(readlink -f ${1})
  target=${2-${HOME}/.${1}}

  if [[ -a $target ]]; then
    echo "$target already exists."
  else
    echo "Linking $src -> $target..."
    ln -s $src $target
  fi
}

# Main
link_file bashrc
link_file bash_aliases
link_file Xmodmap
link_file Xdefaults
link_file vim/
link_file vimrc
link_file pentadactyl/
link_file pentadactylrc
link_file pystartup
link_file xmonad/
link_file xmobarrc
link_file xscreensaver

gitconfig_setup

git submodule init
git submodule update

# Fedora-specific installation
sudo dnf install \
  vim-enhanced vim-X11 \
  xmonad xmobar stalonetray \
  tabbed rxvt-unicode-256color-ml terminus-fonts-console \
  feh \
  python python-pip python-virtualenv python-virtualenvwrapper python-flake8 \
  python3 python3-pip python3-flake8 \
  htop the_silver_searcher \
  inotify-tools dunst \
  xbacklight \
  xscreensaver \
  xclip acpi

vim +PluginInstall +qa

xmonad --recompile
