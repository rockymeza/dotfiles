#!/bin/sh

nm-applet &             # assuming you're using Network Manager
if ssh-add -l | grep "The agent has no identities"; then
  ssh-add .ssh/identity .ssh/id_rsa </dev/null
fi

# scim stuff
export XMODIFIERS="@im=SCIM"
export GTK_IM_MODULE="scim"
scim -d
export LANG="en_US.utf8"

exec awesome            # awesome receives xinit's process id; when it terminates, X will be terminated
