#!/bin/sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

bspwm="$HOME/.config/polybar/config.bspwm"
herbstluftwm="$HOME/.config/polybar/config.herbstluftwm"
config="$HOME/.config/polybar/config"

case "$1" in
    bspwm) config="$bspwm" ;;
    herb) config="$herbstluftwm" ;;
esac

# Launch bar1 and bar2
for monitor in $(polybar --list-monitors | cut -d ":" -f1); do
    MONITOR=$monitor polybar seraphybr -c "$config" --reload --quiet &
    MONITOR=$monitor polybar seraphybr_bottom -c "$config" --reload --quiet &
done 

echo "Bars launched..."
dunstify -u low  "Bars launched"

