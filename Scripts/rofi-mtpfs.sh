#! /bin/sh
#
# rofi-mtpfs.sh
# Copyright (C) 2019 seraphybr-fun <seraphybr-fun@funtoo-z40>
#
# Distributed under terms of the MIT license.
#

MOUNT="$HOME/usb"
DEVICE="$(simple-mtpfs -l | rofi -dmenu -p "MTP:" | cut -d ":" -f1)"

if [ ! -d "$MOUNT" ]
then
    mkdir "$MOUNT"
fi

if [ "$DEVICE" != "" ]
then
    fusermount -u -q "$MOUNT"
    simple-mtpfs --device "$DEVICE" "$MOUNT"
else
    rofi -e "No raw devices found!"
fi

