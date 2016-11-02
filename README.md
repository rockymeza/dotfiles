# dotfiles

Here's where I keep a lot of my configuration stuff.

## Steps

1.  Generate an SSH Key

        $ ssh-keygen -t rsa -b 4096 -C "rocky@example.com"

2.  Upload the SSH key to [GitHub](https://github.com/settings/ssh).

3.  Clone this repository.

        $ cd ~
        $ mkdir projects
        $ cd projects
        $ git clone git@github.com:rockymeza/dotfiles
        $ cd dotfiles

4.  Delete some default files.

        $ rm ~/.bashrc
        $ rm -r ~/Music ~/Pictures # etc.

5.  Password-less sudo

        $ sudo visudo
        # look for the line about %wheel and uncomment it

6.  Run the `install.sh` script. It will link up the dotfiles and install lots
    of packages.

        $ ./install.sh

7.  Run yeganesh a couple of times in order for it to learn about your programs.

        $ yeganesh -x
        (Hit Esc)
        $ yeganesh -x
        (Hit Esc)

8.  Kill the `gdm` process so that it can pick up on xmonad. (Note this will log
    out out).

        $ sudo pkill gdm
