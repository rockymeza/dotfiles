#!/bin/sh

  nm-applet &             # assuming you're using Network Manager
  gnome-power-manager &   # for laptops and stuff
  gnome-volume-manager &  # for mounting CDs, USB sticks, and such
  gnome-do &              # for things I can't otherwise do
  exec awesome            # awesome receives xinit's process id; when it terminates, X will be terminated
