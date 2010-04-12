#-------------------------------------------------------
#    Wrapper for ps auwxx that removes the 'grep'
#    result
#-------------------------------------------------------
process() 
{
  if [ "$#" -ne 1 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Usage: process [process-name]" >&2
    return 1
  fi
  
  ps auwxx | grep -i "$1" | grep -v grep
}