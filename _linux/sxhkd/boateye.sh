#!/bin/bash

zoom_w=300
zoom_h=16384
zoom_x=750
zoom_y=$(( (900 - zoom_h) / 2 ))

normal_w=1600
normal_h=900
normal_x=0
normal_y=0

normal_multiplier=0.25
zoom_multiplier=0.03125
device_id="E-Signal USB Gaming Mouse"

# Get active window info
eval "$(xdotool getactivewindow getwindowgeometry --shell)"
title="$(xdotool getactivewindow getwindowname)"

if [[ "$title" == *"Minecraft"* && "$HEIGHT" -eq "$normal_h" ]]; then
    wmctrl -r ":ACTIVE:" -e "0,${zoom_x},${zoom_y},${zoom_w},${zoom_h}"
    xinput set-prop "$device_id" 'Coordinate Transformation Matrix' \
        $zoom_multiplier 0 0 0 $zoom_multiplier 0 0 0 1
else
    wmctrl -r ":ACTIVE:" -e "0,${normal_x},${normal_y},${normal_w},${normal_h}"
    xinput set-prop "$device_id" 'Coordinate Transformation Matrix' \
        $normal_multiplier 0 0 0 $normal_multiplier 0 0 0 1
fi
