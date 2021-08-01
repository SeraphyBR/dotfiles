#!/bin/sh

# Make sure this is before the 'exec' command or it won't be sourced.
[ -f ~/.xprofile ] && . "$HOME"/.xprofile

if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
    eval $(dbus-launch --exit-with-session --sh-syntax)
fi
systemctl --user import-environment DISPLAY XAUTHORITY

if command -v dbus-update-activation-environment >/dev/null 2>&1; then
    dbus-update-activation-environment DISPLAY XAUTHORITY
fi

# Restarts gnome-keyring as user
# Fix for using with home-manager
gnome-keyring-daemon -r
export SSH_AUTH_SOCK

# If using nvidia as main graphics card
xrandr --setprovideroutputsource 1 0
xrandr --auto

#exec  awesome
