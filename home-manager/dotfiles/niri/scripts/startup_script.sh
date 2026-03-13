#!/usr/bin/env bash

# make cursor strictly first
hyprctl setcursor ComixCursors-Black 40

# 1. Start hyprlock strictly first
# It runs in the background so the script can proceed with timers
hyprlock & 

# 2. WAIT 2.5 seconds (1.5s + 1.0s extra)
# This gives you plenty of time to start typing before Waybar launches
# sleep 2.5

# 3. Start Waybar
waybar &

# 4. WAIT 1.5 seconds (0.5s + 1.0s extra)
# Added extra time before swww starts to ensure Waybar is settled
# sleep 1.5

# 5. Start swww daemons at the same time
swww-daemon &
swww-daemon -n overlay &

# 6. Final initialization and transition
# Give daemons a moment to open their sockets before sending the image
# sleep 2
# swww img "$HOME/.cache/current_wallpaper.png" --transition-type grow --transition-duration 2 &
# swww img -n overlay "$HOME/.cache/blurred_wallpaper.png" --transition-type grow --transition-duration 2 &

# Keep script alive until hyprlock is closed
wait