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
    $@
    if [[ "$?" -eq 0 ]]; then
      notify-send 'completed task' $task
    else
      notify-send -u critical 'task failed!' $task
    fi
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

