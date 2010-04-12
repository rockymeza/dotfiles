#-------------------------------------------------------
#    Changes Mac OS X login background
#-------------------------------------------------------
function loginbg()
{
  if [ "$#" -ne 1 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Usage: loginbg [path/to/image]" >&2
    return 1
  fi
  
  echo "* Assigning ${1} to the login screen..." 
  sudo cp /System/Library/CoreServices/DefaultDesktop.jpg /System/Library/CoreServices/DefaultDesktop.jpg.bak
  sudo cp $1 /System/Library/CoreServices/DefaultDesktop.jpg
  echo "* Completed!" 
}