#!/usr/bin/env bash
#-------------------------------------------------------
#    Create an archive from a set of files
#-------------------------------------------------------
archive()
{
  if [ "$#" -ne 2 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Usage: archive [--tgz --zip --7z] [path/to/directory]" >&2
    return 1
  fi
  
  if [ ! -d $2 ]; then
    echo "$2 is not a valid directory of files"
    return 1
  else
    arch_base_name=$(basename $2)
    case $1 in
      --tgz)  tar cvf ${arch_base_name}.tar.gz $2 ;;
      --zip)  zip ${arch_base_name}.zip $2        ;;
      --7z)   7za a ${arch_base_name}.7z $2       ;;
      *)                                          ;;  
    esac
  fi
}