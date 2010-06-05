#!/usr/bin/env bash
#--------------------------------------------------
#    Defines a "branch" block in a .git/config file
#--------------------------------------------------
gconfbr()
{
  if [ "$#" -ne 2 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Usage: gconfbr [remote] [branch]" >&2
    return 1
  fi

  check_git || echo "Not a git repository" && return 1

  git_dir=$(git_info -d)
  cat >> $git_dir/config <<BLOCK
[branch "${2}"]
        remote = ${1}
        merge = refs/heads/${2}
BLOCK
}
