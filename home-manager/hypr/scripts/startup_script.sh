#!/usr/bin/env bash
waybar &
awww-daemon &
awww img "$HOME/.cache/current_wallpaper.png" --transition-type grow --transition-duration 1.75 &
wait
