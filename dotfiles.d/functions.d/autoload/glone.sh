#!/usr/bin/env bash
#--------------------------------------------------
#    Easy wrapper for git clone
#--------------------------------------------------
glone()
{
  if [ "$#" -gt 2 ] || [ "$#" -eq 0 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Usage: glone [host] [repo-name]" >&2
    return 1
  fi
 
  if [ "$#" -eq 1 ]; then
    git clone ${1}
  else  
    git clone git@${1}:${2}
  fi
}
