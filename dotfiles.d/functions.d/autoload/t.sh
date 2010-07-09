#!/usr/bin/env bash
#----------------------------------------------
#    Toggle directories
#----------------------------------------------
t()
{
  if [[ "$#" -ne 1 ]]; then
    if [[ -n "$T_TOGGLE_DIRECTORY_1" ]] && [[ -n "$T_TOGGLE_DIRECTORY_2" ]]; then
      if [[ "$T_TOGGLE_DIRECTORY_1" == "$PWD" ]]; then
        cd $T_TOGGLE_DIRECTORY_2
      else
        cd $T_TOGGLE_DIRECTORY_1
      fi
    else
      echo "Please specify a directory first" >&2
      return 1
    fi
  else
    T_TOGGLE_DIRECTORY_1=$PWD
    cd $1
    T_TOGGLE_DIRECTORY_2=$PWD
  fi
}
