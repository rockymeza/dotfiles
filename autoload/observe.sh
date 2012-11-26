# you need to install inotify-tools
# also it depends on fy
function observe()
{
  ($@)

  while inotifywait --quiet --exclude '^\..*\.swp$' --event modify --recursive .; do
    FY_PROGRAM_NAME='observe' fy $@
  done
}
