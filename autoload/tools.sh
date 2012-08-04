function md()
{
  mkdir $1 && cd $1;
}


function wo()
{
  workon $1 && b $1;
}
