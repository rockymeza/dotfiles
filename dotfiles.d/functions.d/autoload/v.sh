#!/usr/bin/env bash
#-------------------------------------------------------
#    A simple volume setting program
#-------------------------------------------------------
v()
{
  if [[ "$#" -eq 0 ]]; then
    __v_get
  elif [[ "$#" -eq 1 ]]; then
    if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
      __v_usage
    elif [[ $1 == "-s" ]] || [[ "$1" == "--scale" ]]; then
      __v_scale
    else
      volume=$(echo -e "$1\n6.4\n*\np" | dc)
      __v_set $volume
      __v_get
    fi
  else
    __v_usage
  fi
}

__v_get()
{
  amixer sget Master,0 | grep 'Mono:' | sed 's/^[^\[]*\[\([0-9]*%\).*$/\1/'
}

__v_set()
{
  amixer -q sset Master,0 $1 >/dev/null 2>&1
}

__v_scale()
{
  amixer sget Master,0 | grep 'Mono:' | sed 's/^[^0-9]*\([0-9]*\).*$/\1/'
}

__v_usage()
{
  cat <<HEREDOC
v, a simple volume setting program

Usage:
      v volume

Options:
      -h, --help            Show this help screen
      -s, --scale           Display the volume on a 0-64 scale

Notes:
      Volume is on a 0-10 scale
HEREDOC
}
