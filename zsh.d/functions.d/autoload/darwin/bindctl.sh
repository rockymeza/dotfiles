#-------------------------------------------------------
#    Easy wrapper for starting, stopping, and restarting 
#    BIND
#-------------------------------------------------------
function bindctl()
{
  if [ "$#" -ne 1 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Usage: bindctl [start|stop|restart]" >&2
    return 1
  fi
  
  case "$1" in
    start)
      sudo launchctl load /System/Library/LaunchDaemons/org.isc.named.plist
      echo "* Bind loaded"
      ;;
    stop)
      sudo launchctl unload /System/Library/LaunchDaemons/org.isc.named.plist
      echo "* Bind unloaded"
      ;;
    restart)
      sudo launchctl unload /System/Library/LaunchDaemons/org.isc.named.plist
      sudo launchctl load /System/Library/LaunchDaemons/org.isc.named.plist
      echo "* Bind restarted"
      ;;
    *)
      echo "Usage: bindctl [start|stop|restart]" >&2
      ;;
  esac
}