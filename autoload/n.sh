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

      return 0
    else
      notify-send -u critical 'task failed!' $task
      echo -ne '\a'

      return 1
    fi
  fi
}

__n_usage()
{
  cat <<HEREDOC
n, a little notification program
n runs a command and then notifies you that the
command has finished running using notify-send.

Usage:
      n command

Options:
      -h, --help            Show this help screen
HEREDOC
}

