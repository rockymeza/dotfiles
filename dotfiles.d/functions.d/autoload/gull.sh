#--------------------------------------------------
#    Does a git pull on the current branch (using
#    it's associated remote, if present)
#--------------------------------------------------
gull()
{
  __git_exec_file_move pull "$@"
}