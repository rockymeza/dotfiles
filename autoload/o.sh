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
          $EDITOR $1
        else
          $PAGER $1
        fi
      fi
    else
      curl_response=$(curl -I -s $1 | head -n 1 | sed 's/^.*\([0-9]\{3\}\).*$/\1/')
      if [[ "$curl_response" == "200" ]] || [[ "$curl_response" == "301" ]]; then # returns a successful HTTP status
        if [[ ! -z $BROWSER ]]; then 
          $BROWSER $1
        else
          /usr/bin/x-www-browser $1
        fi
      else
        echo "I don't know what to do" # give up
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
      o path/to/file/or/directory/or/url

Options:
      -h, --help            Show this help screen
HEREDOC
}

