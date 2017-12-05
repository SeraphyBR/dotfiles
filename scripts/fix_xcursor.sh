#! /bin/bash
sed -e "s/Xcursor.theme:.*/Xcursor.theme: $(awk -F= '/gtk-cursor-theme-name=/{print $2}' ~/.gtkrc-2.0)/" -e "s/[\"]//g" ~/.Xresources
xrdb ~/.Xresources
exit
