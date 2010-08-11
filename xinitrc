#!/bin/sh

# gnome-settings-daemon & # handles themes, starts gnome-screensaver. You may have to use gconf to disable it setting the background.
 nm-applet &             # assuming you're using Network Manager
 sleep 2
 gnome-power-manager &   # for laptops and stuff
 gnome-volume-manager &  # for mounting CDs, USB sticks, and such
 gnome-do &              # for things I can't otherwise do
 exec awesome            # awesome receives xinit's process id; when it terminates, X will be terminated


