#!/bin/sh

# Make sure this is before the 'exec' command or it won't be sourced.
[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

if [ "$2" = "bspwm" ] || [ "$2" = "" ]; then
    exec ck-launch-session dbus-launch --sh-syntax --exit-with-session bspwm
fi
