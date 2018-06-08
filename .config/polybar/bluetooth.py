#!/usr/bin/python3
# Esse script depende do tlp instalado

import subprocess

icon_enabled="  "
icon_disabled="  "

status = stdoutdata = subprocess.getoutput("bluetooth")

if (status == "bluetooth = on"):
    print (icon_enabled)
else:
    print (icon_disabled)
