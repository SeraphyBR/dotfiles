#!/bin/sh

# Script criado para ser usado como modulo para o polybar,
# vai dizer se a placa nvidia está em uso ou não.


if [ -e /proc/acpi/bbswitch ]
then
    if grep -qs "ON" /proc/acpi/bbswitch
    then
        echo " Nvidia %{F#7FFF00}  %{F-} "
    else
        echo " Nvidia %{F#7FFF00}  %{F-} "  
    fi
fi
