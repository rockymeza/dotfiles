# cd to a directory and start a Python HTTP server there. Open the page in
# Google Chrome.  Based on what I saw Paul Irish do.
function server()
{
  [ $1 ] && dir=$1 || dir='.'
  [ $2 ] && port=$2 || port=8000

  cd $dir
  (sleep 1 && google-chrome "http://localhost:$port")
  # if I were on mac, I would do this instead
  # (sleep 1 && open "http://localhost:$port")
  python -m SimpleHTTPServer $port
  cd -
}
