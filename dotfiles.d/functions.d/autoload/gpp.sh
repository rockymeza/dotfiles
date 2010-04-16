#!/usr/bin/env bash
#--------------------------------------------------
#    Does a git pp on the current branch (using
#    it's associated remote, if present)
#--------------------------------------------------
gpp()
{
  __git_exec_file_move pp "$@"
}