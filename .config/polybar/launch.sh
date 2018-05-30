#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
MONITOR=eDP1 polybar seraphybr &
MONITOR=HDMI1 polybar seraphybr &
MONITOR=eDP1 polybar seraphybr_bottom &
MONITOR=HDMI1 polybar seraphybr_bottom &
MONITOR=DP1 polybar seraphybr_bottom &
echo "Bars launched..."
dunstify -u low  "Bars launched"
