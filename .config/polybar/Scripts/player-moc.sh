#!/bin/sh

# Change according to information you wish to show in your polybar:
#        %state     State
#        %file       File
#        %title     Title
#        %artist    Artist
#        %song      SongTitle
#        %album     Album
#        %tt        TotalTime
#        %tl        TimeLeft
#        %ts        TotalSec
#        %ct        CurrentTime
#        %cs        CurrentSec
#        %b         Bitrate
#        %r         Rate

if [ "$(mocp -Q %state)" != "STOP" ];then
    SONG=$(mocp -Q %song)

    if [ -n "$SONG" ]; then
        echo "$SONG - $(mocp -Q %album)"
    else
        basename "$(mocp -Q %file)"
    fi
else
    echo ""
fi
