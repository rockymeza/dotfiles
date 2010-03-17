#--------------------------------------------------
#    Easy wrapper for git clone
#--------------------------------------------------
glone()
{
  if [ "$#" -ne 2 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Usage: glone [host] [repo-name]" >&2
    return 1
  fi
 
  git clone git@${1}:${2}
}