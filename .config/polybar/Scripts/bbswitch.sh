#!/bin/bash
# script criado para ser usado como modulo para o polybar,
# vai dizer se a placa nvidia está em uso ou não.

    if grep -q "ON" /proc/acpi/bbswitch 
    then
      echo "Nvidia %{F#7FFF00}  %{F-}"
  else
      echo "Nvidia %{F#7FFF00}  %{F-}"  
    fi
