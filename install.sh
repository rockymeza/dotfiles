#!/usr/bin/env bash
gitconfig_setup()
{
  name=$(git config --global user.name)
  email=$(git config --global user.email)
  
  if [ -a ${HOME}/.gitconfig ]; then
    rm ${HOME}/.gitconfig
    cp ${PWD}/gitconfig ${HOME}/.gitconfig
  else
    cp ${PWD}/gitconfig ${HOME}/.gitconfig
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
  
  git config --global core.excludesfile ~/.gitignore
}

help_message()
{
  echo "Usage: ./install.sh [option]"
  echo "Possible options: install, gc"
}

in_array()
{
  haystack=( "$@" )
  haystack_size=( "${#haystack[@]}" )
  needle=${haystack[$((${haystack_size}-1))]}
  for ((i=0;i<$(($haystack_size-1));i++)); do
    h=${haystack[${i}]};
    [ $h = $needle ] && return 0
  done
}

link_file()
{
  echo "Linking ~/.${1}..."
  ln -s ${PWD}/${1} ${HOME}/.${1}
}

replace_file()
{
  echo "Removing old ~/.${1}..."
  rm ${HOME}/.${1}
  link_file $1
}

if [ $# -ne 1 ] || [ $1 == "-h" ] || [ $1 == "--help" ]; then
  help_message
else
  case $1 in
    install)
      replace_all=false
      skipped_files=(Rakefile install.sh gitconfig apache bind9 dotfiles.d)
      for i in *
      do
        file=$i
        [[ $file =~ .*~$ ]] && continue
        in_array "${skipped_files[@]}" "$i"
        if [ $? -ne 0 ]; then
          if [ -a ${HOME}/.${file} ]; then
            if $replace_all; then
              replace_file $file
            else
              read -p "Overwrite ~/.${file}? [yNaq]: " response
              case $response in
                a) replace_all=true
                   replace_file $file;;
                y) replace_file $file;;
                q) exit;;
                *) echo "Skipping ~/.${file}";;
              esac
            fi
          else
            link_file $file
          fi
        fi
      done;
      gitconfig_setup;;
    gc) gitconfig_setup;;
    *)  help_message;;
  esac
fi
