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
use Getopt::Long;
use Switch;

#|
#|  Regex to define user/host combos in the
#|  form user@host:port
#|
my $userHostRegex = '\w+@[.\w\d-]+(?::\d+)?';

#|
#|  Regex to define *nix paths.
#|
my $pathRegex = '~?[*\w/\\\.\\s-]+';

#|
#|  Regex to define scp combinations; since
#|  these are such unique beasts, we have to
#|  form a special regex just for them.
#|
my $scpRegex = "($pathRegex\\s$userHostRegex:(?:$pathRegex)?|$userHostRegex:$pathRegex\\s$pathRegex)";

#|
#|  Assembles a ssh/sftp/scp command and
#|  executes it.  It expects 3 parameters:
#|    1. $option  - ssh|sftp|scp
#|    2. $command - basically whatever comes after #1
#|    3. $regex   - the regex to test the command against
#|
sub parseAndRun
{
  my ($option, $command, $regex) = @_;
  if ($command =~ m/$regex/i)
  {
    my $newCommand = "$option";
    if ($& =~ m/:(\d+)/)
    {
      my $portString = '';
      $command =~ s/:(\d+)//;
      switch ($option)
      {
        case ('ssh')      { $portString = "-p $1"; }
        case (/sftp|scp/) { $portString = "-oPort=$1"; }
      }      
      $newCommand .= " $portString";
    }

    $newCommand .= " $command";
    system($newCommand);
  }
  else
  {
    print "Bad match for $command (using $regex)\n";
    return 1;
  }
}

#|
#|  Prints the usage message.
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
my ($ssh, $sftp) = '', my @scp;
GetOptions('ssh=s' => \$ssh, 'sftp=s' => \$sftp, 'scp=s{2}' => \@scp);

if    ($ssh)  { parseAndRun('ssh', $ssh, "^$userHostRegex\$"); }
elsif ($sftp) { parseAndRun('sftp', $sftp, "^$userHostRegex\$"); }
elsif (@scp)
{
  # Since scp really has two arguments - a user/host combo and
  # a path - we need to assemble it into one string that
  # parseAndRun can accept.
  my $scpString = '';
  foreach (@scp) { $scpString .= $_ . ' '; }
  $scpString =~ s/\s+$//;
  parseAndRun('scp', $scpString, "$scpRegex\$");
}
else { printUsageMessage(); }
