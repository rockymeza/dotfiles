#!/usr/bin/env bash
#----------------------------------------------
#    Bookmarking for  directories
#----------------------------------------------
BOOKMARKS_FILE=$HOME/.b_bookmarks

if [[ ! -f "$BOOKMARKS_FILE" ]]; then
  touch "$BOOKMARKS_FILE"
fi

b()
{
  if [[ "$#" -eq 1 ]]; then
    if [[ $1 == "-h" ]] || [[ $1 == "--help" ]]; then
      __b_usage
    else
      __b_cd $1
    fi
  elif [[ "$#" -eq 2 ]]; then
    __b_add $1 $2
  else
    __b_list
  fi
}

__b_list()
{
  if [[ -s "$BOOKMARKS_FILE" ]]; then
    echo "List of bookmarks:"
    cat "$BOOKMARKS_FILE"
  else
    echo "You have not set any bookmarks."
  fi
}

__b_add()
{
  __b_find_mark $1
  if [[ -n "$__b_mark" ]]; then
    echo "That bookmark is already in use."
  else
    if [[ $2 == "." ]]; then
      dir=$PWD
    elif [[ $2 == ".." ]]; then
      dir=$(echo $PWD | sed 's/^\(\/.*\)\/[^/]*$/\1/')
    else
      dir=$2
    fi
    echo "$1,$dir" >> $BOOKMARKS_FILE
    echo "Added $1,$dir to bookmarks list"
  fi

}

__b_cd()
{
  __b_find_mark $1
  if [[ -n "$__b_mark" ]]; then
    dir=$(echo $__b_mark | sed 's/^[^,]*,\(.*\)/\1/')
    cd $dir
  else
    echo "That bookmark does not exist."
  fi
}

__b_find_mark()
{
  __b_mark=$(cat "$BOOKMARKS_FILE" | grep "^$1,")
}

__b_usage()
{
  cat <<HEREDOC
b, a simple bookmarking system

Usage:
      b [options] [bookmark] [directory]

Options:
      -h, --help            Show this help screen

Notes:
      If b is run with no arguments, it will list all of the bookmarks.
      If it is given a bookmark, it will attempt to cd into that bookmark.
      If it is given a bookmark and directory, it will create that bookmark.

Examples:
    $ b
      List of bookmarks:
      home,/home/user
      ..
    $ b home
      will cd to the home directory
    $ b home /home/user
      Added home,/home/user to bookmark list    
HEREDOC
}

