#!/bin/bash

sleep 5

# set xkb map
xkbcomp -I/home/${USER}/.config/xkb/ /home/${USER}/.config/xkb/mymap $DISPLAY

# start conky
conky -c ~/.config/conky/conky-smart 

# enable ctrl+alt+backspace for killing xserver
setxkbmap -option terminate:ctrl_alt_bksp 

# finish with "exit <number>"
exit 0
