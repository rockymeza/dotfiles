#!/usr/bin/env bash
#----------------------------------------------
#    A little notification program
#----------------------------------------------

n()
{
  if [[ "$#" -lt 1 ]] || [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
    __n_usage
  else
    task=''
    for arg in $@
    do
      task="$task$arg "
    done
    $@ && notify-send 'completed task' $task
  fi
}

__n_usage()
{
  cat <<HEREDOC
b, a little notification program

Usage:
      b command

Options:
      -h, --help            Show this help screen
HEREDOC
}

