#-------------------------------------------------------
#    Switches the names of two files
#-------------------------------------------------------
switch() 
{
  if [ "$#" -ne 2 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Usage: switch [file1] [file2]" >&2
    return 1
  fi

  echo "* Switching '${1}' and '${2}'..." 
  mv $1 ${1}.tmp && mv $2 $1 && mv ${1}.tmp $2
  echo "* Files switched!"
}