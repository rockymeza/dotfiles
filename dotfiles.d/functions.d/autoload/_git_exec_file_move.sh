#!/usr/bin/env bash
#-------------------------------------------------------
#   Generic function that most of my git "moving"
#   functions extend.  Basically ties git execution to
#   a branch and associated origin.
#-------------------------------------------------------
__git_exec_file_move()
{
  local remote=""
  local branch=$(git_info -b)
  local command=$1
  shift

  if [ -z "$branch" ]; then
    return 1
  fi

  while [ "$1" != "" ]; do
    case $1 in
      -b | --branch )         
        branch=$2
        shift
        ;;
      -h | --help )
        echo "Usage: git ${command} [[-b branch ] | [-h]]"
        return
        ;;
      * )                     
        ;;
    esac
    shift
  done

  if [ -z "$branch" ]; then
    echo "You provided the -b flag, but did not specify a branch"
    return
  fi

  remote=$(git config branch.${branch}.remote)
  if [ -z "$remote" ]; then
    echo "There is no matching remote for branch '${branch}' in your .git/config file.  Defaulting to remote 'origin'."
    remote="origin"
  fi

  git $command $remote $branch
}
