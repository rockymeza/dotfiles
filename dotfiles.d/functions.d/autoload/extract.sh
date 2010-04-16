#!/usr/bin/env bash
#-------------------------------------------------------
#    Extract files from an archive
#-------------------------------------------------------
extract() 
{
  if [ "$#" -ne 1 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Usage: extract [archive]" >&2
    return 1
  fi
  
  if [ -f $1 ]; then
    case $1 in
      *.tar.bz2)  tar xvjf $1     ;;
      *.tbz)      tar xvjf $1     ;;
      *.tar.gz)   tar xvzf $1     ;;
      *.bz2)      bunzip2 $1      ;;
      *.gz)       gunzip $1       ;;
      *.tar)      tar xvf $1      ;;
      *.tbz2)     tar xvjf $1     ;;
      *.tgz)      tar xvzf $1     ;;
      *.zip)      unzip $1        ;;
      *.7z)       7za x $1        ;;
      *)          echo "'$1' is not a valid archive" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}