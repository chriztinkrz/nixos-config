#!/usr/bin/env bash
if pgrep "waybar" > /dev/null
then
    pkill waybar
    hyprctl keyword general:gaps_out 16 16 16 16
else
    waybar &
    hyprctl keyword general:gaps_out 11 16 16 16
fi
