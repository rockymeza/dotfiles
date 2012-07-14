function observe()
{
  while inotifywait --exclude '^\..*\.swp$' --event modify --recursive .; do
    task=""
    for arg in $@; do
      task="$task$arg "
    done

    $@ && notify-send "observe" "$task"
  done
}
