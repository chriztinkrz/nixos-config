#!/usr/bin/env bash
hyprlock &
zen-beta &
sleep 1
waybar &
vicinae server &
awww-daemon &
wait
