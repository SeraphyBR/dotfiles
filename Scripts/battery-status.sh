#!/bin/sh

ICON=/usr/share/icons/Papirus/48x48/devices/battery.svg

while true
do
    battery_level=$(acpi -b | grep -P -o '[0-9]+(?=%)')
    if on_ac_power; then
        if [ "$battery_level" -ge 80 ]; then
            notify-send -i $ICON "Bateria está carregando acima de 80%!" "Por favor tire-o da tomada!"
            sleep 20
        fi
    else
        if [ "$battery_level" -le 15 ]; then
            notify-send -u critical -i $ICON "Bateria está abaixo de 15%!" "Precisa carregar! Por favor plugue o na tomada!."
            sleep 20
            if ! on_ac_power; then
                xbacklight -set 10
            fi
        fi
    fi

    sleep 300 # 300 seconds or 5 minutes
done
