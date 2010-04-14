#!/usr/bin/env perl
#-------------------------------------------------------------------------------------------------------------
#  psh.pl
#  A wrapper for ssh, sftp, and scp that looks innoculous enough at first 
#  glance:
#
#    psh.pl --ssh user@host                => ssh user@host
#    psh.pl --sftp user@host               => sftp user@host
#    psh.pl --scp /home/file.txt user@host => scp /home/file.txt user@host
#  
#  However, psh.pl has an added advantage: to specify a different port,
#  all one has to do is append :{port-number} to the end of the string:
#
#    psh.pl --ssh user@host:2321                => ssh -p 2321 user@host
#    psh.pl --sftp user@host:2321               => sftp -oPort=2321 user@host
#    psh.pl --scp /home/file.txt user@host:2321 => scp -oPort=2321 /home/file.txt user@host
#
#  Again, perhaps not *the* most exciting thing in the world.  But what if it were combined 
#  with user/host combinations stored in environment variables?  Imagine these:
#
#    export host1=user@host1:22981
#    export host2=user@host2:8872
#
#  Instead of having to type out long, complicated ssh/sftp/scp strings, psh.pl allows you
#  to do the following:
#
#    psh.pl --ssh $host1                             => ssh -p 22981 user@host1
#    psh.pl --sftp $host1                            => sftp -oPort=22981 user@host1
#    psh.pl --scp $host2:/home/file.txt .            => scp -oPort=8872 user@host2:/home/file.txt .
#    psh.pl --scp ~/other_file.pdf $host2:/home/user => scp -oPort=8872 ~/other_file.pdf user@host2:/home/user
#
#  Cool!
#-------------------------------------------------------------------------------------------------------------
use warnings;
use strict;
use Switch;

my $userRegex = '(?:[a-z0-9+!*(),;?&=\$_.-]+(?::[a-z0-9+!*(),;?&=\$_.-]+)?@)?';
my $hostRegex = '[a-z0-9-.]*\.[a-z]{2,3}';
my $portRegex = '(?::[0-9]{2,5})?';
my $pathRegex = '~?[*\w/\\\.\\s-]+';

#|
#|  Regex to define user/host combos in the
#|  form user@host:port
#|
my $userHostRegex = "$userRegex$hostRegex$portRegex";

#|
#|  Regex to define scp combinations; since
#|  these are such unique beasts, we have to
#|  form a special regex just for them
#|
my $scpRegex = "($pathRegex\\s$userHostRegex:(?:$pathRegex)?|$userHostRegex:$pathRegex\\s$pathRegex)";

#|
#|  Simple function to determine whether a
#|  key exists in an array
#|
sub array_contains {
	my $array = shift;
	my $key = shift;

	my $contains = 0;
	foreach(@$array) {
		$contains = 1 if ($_ eq $key);
	}
	return $contains;
}

#|
#|  Assembles a ssh/sftp/scp command with
#|  expects 3 parameters:
#|    1. $option  - ssh|sftp|scp
#|    2. $command - basically whatever comes after #1
#|    3. $regex   - the regex to test the command against
#|
sub createCommand
{
  my ($command, $optionString, $regex) = @_;
  
  if ($optionString =~ m/$regex/i)
  {
    my $newCommand = "$command";
    if ($& =~ m/:(\d+)/i)
    {
      my $portString = '';
      switch ($command)
      {
        case ('ssh')      { $portString = "-p $1"; }
        case (/sftp|scp/) { $portString = "-oPort=$1"; }
      }
      
      $optionString =~ s/$&//;
      $newCommand .= " $portString";
    }
    
    $newCommand .= " $optionString";
    return "$newCommand\n";
  }
  else
  {
    print "Bad match for $command (using $regex)\n";
    return 1;
  }
}

#|
#|  Takes a raw string of ssh/scp/sftp options and assembles
#|  them into an executable command
#|
sub execute
{
  my $optionString = '';
  my ($args, $command, $regex) = @_;

  foreach (@{$args}) { if ( $_ ne "--$command" ) { $optionString .= $_ . ' '; } }
  system(createCommand($command, $optionString, $regex));
}

#|
#|  Prints the usage message
#|
sub printUsageMessage 
{ 
  print "Usage:
  psh.pl --ssh user\@host[:port]
  psh.pl --sftp user\@host[:port]
  psh.pl --scp /path/to/file user\@host[:port]:[/remote/path]
  psh.pl --scp user\@host[:port]:/remote/path/to/file /local/path\n";
}


#---------------------- MAIN PROGRAM ----------------------#

#|
#|  Pull options from the command line.  If more than one
#|  is specified, the first one will be run.  If no valid
#|  option is passed, the usage message is printed.
#|
if (array_contains(\@ARGV, '--ssh'))     { execute(\@ARGV, 'ssh', $userHostRegex); }
elsif (array_contains(\@ARGV, '--scp'))  { execute(\@ARGV, 'scp', $scpRegex) ; }
elsif (array_contains(\@ARGV, '--sftp')) { execute(\@ARGV, 'sftp', $userHostRegex); }
else { printUsageMessage(); }