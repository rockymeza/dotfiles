#-------------------------------------------------------
#    Performs a 'cd ../' n times (where n is given)
#-------------------------------------------------------
up()
{
  if [ "$#" -gt 1 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Usage: up [number-of-dirs]" >&2
    return 1
  fi
  
  local arg=${1:-1}
  local dir=""
  while [ $arg -gt 0 ]; do
    dir="../${dotfile_dir}"
    arg=$(($arg - 1));
  done
  cd $dir >&/dev/null
}