# cd to a directory and start a Python HTTP server there. Open the page in
# Google Chrome.  Based on what I saw Paul Irish do.
function server()
{
  [ $2 ] && port=$2 || port=8000

  cd $1
  (sleep 1 && google-chrome "http://localhost:$port")
  python -m SimpleHTTPServer
  cd -
}
