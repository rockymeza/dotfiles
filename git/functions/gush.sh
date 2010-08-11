#!/usr/bin/env bash
#--------------------------------------------------
#    Does a git push on the current branch (using
#    it's associated remote, if present)
#--------------------------------------------------
gush()
{
  __git_exec_file_move push "$@"
}