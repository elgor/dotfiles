#!/bin/bash

sleep 5
# set xkb map
xkbcomp -I/home/emu/.config/xkb/ /home/emu/.config/xkb/mymap $DISPLAY

# start conky
conky -c ~/.config/conky/conky-smart 


# finish with "exit <number>"
exit 0
