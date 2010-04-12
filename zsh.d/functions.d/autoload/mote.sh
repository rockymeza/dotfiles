#--------------------------------------------------
#    Displays information about a given git remote
#--------------------------------------------------
mote()
{
	if [ "$#" -ne 1 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Usage: mote [remote-name]" >&2
    return 1
  fi

  git remote show $1
}