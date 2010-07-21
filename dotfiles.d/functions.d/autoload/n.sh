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
n, a little notification program
n runs a command and then notifies you that the
command has finished running using notify-send.

Usage:
      n command

Options:
      -h, --help            Show this help screen
HEREDOC
}

