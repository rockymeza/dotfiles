#!/usr/bin/env bash
#-------------------------------------------------------
#    Wrapper for ps auwxx that removes the 'grep'
#    result
#-------------------------------------------------------
volume() 
{
  if [ "$#" -ne 1 ]; then
    amixer sget Master,0
  fi

  if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Usage: volume [0-64]" >&2
    return 1
  fi
  amixer sset Master,0 $1
}
