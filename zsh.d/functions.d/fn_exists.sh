#-------------------------------------------------------
#    Determines whether a function is recognized by
#    the shell
#-------------------------------------------------------
fn_exists()
{
	if [ "$#" -ne 1 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Usage: fn_exists [function-name]" >&2
    return 1
  fi

  type $1 &>/dev/null && echo "${1}() found" || echo "${1}() not found"
}