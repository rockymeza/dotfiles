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

  local is_git=$(get_git_prompt_info "%b")
  if [ -n "$is_git" ]; then
    cat >> .git/config <<BLOCK
[branch "${2}"]
        remote = ${1}
        merge = refs/heads/${2}
BLOCK
  fi
}