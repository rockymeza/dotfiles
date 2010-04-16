#!/usr/bin/env bash
#--------------------------------------------------
#    Fetches, diffs, and prompts user to merge
#    (using current branch and it's associated 
#    remote, if present)
#--------------------------------------------------
getch()
{
  __git_exec_file_move fetch "$@"
  git diff -R FETCH_HEAD
  
  local needs_merge=$(git diff -R FETCH_HEAD | grep diff 2> /dev/null)
  if [ -n "$needs_merge" ]; then
    echo -n 'Do you want to merge? (y/n) [n]: '
    read -e merge_option
    if [ "$merge_option" == "y" ]; then
      git merge FETCH_HEAD
    fi
  fi
}