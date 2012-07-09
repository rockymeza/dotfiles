#!/usr/bin/env bash
#----------------------------------------------
#    A little notification program
#
#    (Depends on notify-send)
#----------------------------------------------
fy()
{
  if [[ "$#" -lt 1 ]] || [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
    __fy_usage
  else
    task="$@"

    $@ | __fy_stdin $task
    ret=$?

    if [[ "$ret" -eq 0 ]]; then
      notify-send 'fy: completed task' "$task"
    else
      notify-send -u critical 'fy: task failed!' "$task"

      # alert bell
      echo -ne '\a'
    fi

    return $ret
  fi
}

__fy_stdin()
{
  while read output; do
    echo $output
    notify-send "fy: $@" "$output"
  done
}

__fy_usage()
{
  cat <<HEREDOC
fy, a little notification program

fy runs a command and then notifies you that the command has finished running
using notify-send.  It will also capture notify the output of the program while
it is running.

Usage:
      fy command

Options:
      -h, --help            Show this help screen

Example:
      fy ./manage.py migrate
HEREDOC
}
