# you need to install inotify-tools
# also it depends on fy
function observe()
{
  ($@)

  while inotifywait --quiet --exclude '^\.git/|^\..*\.swp$|sqlite_database' --event modify --recursive .; do
    sleep .1
    FY_PROGRAM_NAME='observe' fy $@
  done
}
