#!/usr/bin/env bash
#----------------------------------------------
#    A command-line opener
#----------------------------------------------

o()
{
  if [[ "$#" -lt 1 ]] || [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
    __o_usage
  else
    if [[ -d $1 ]]; then # directory, easy
      cd $1
    elif [[ -f $1 ]]; then # file
      type=$(file -b --mime-type $1 | sed 's/^\([a-z]\+\)\/.*$/\1/')
      if [[ "$type" == "text" ]]; then
        if [[ ! -z $EDITOR ]]; then
          return $EDITOR $1
        else
          return $PAGER $1
        fi
      fi
    else
      curl_response=$(curl -I -s -m 1 $1 | head -n 1 | sed 's/^.*\([0-9]\{3\}\).*$/\1/')
      if [[ "$curl_response" == "200" ]] || [[ "$curl_response" == "301" ]]; then # returns a successful HTTP status
        if [[ ! -z $BROWSER ]]; then 
          return $BROWSER $1
        else
          return /usr/bin/x-www-browser $1
        fi
      else
        echo "I don't know what to do" # give up
        return 1
      fi
    fi
  fi
}

__o_usage()
{
  cat <<HEREDOC
o, opens things
Tries to figure out what something is and than opens it.

Usage:
      o path/to/file/or/directory/or/URL

Options:
      -h, --help            Show this help screen
HEREDOC
}

