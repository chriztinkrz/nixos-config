#!/usr/bin/env bash
hyprctl dispatch togglespecialworkspace magic
# sleep 0.02
hyprctl dispatch movecursor $(hyprctl activewindow -j | jq -r '
  (.at[0] + .size[0]/2 | floor | tostring) + " " +
  (.at[1] + .size[1]/2 | floor | tostring)
')
