#!/usr/bin/env bash
# niri-even-columns.sh
# Resize all tiled windows on the current workspace to equal widths.

set -euo pipefail

# Get the focused workspace ID and focused window ID in one call
focused_json=$(niri msg --json focused-window)
focused_ws=$(echo "$focused_json" | jq '.workspace_id')
original_focus=$(echo "$focused_json" | jq '.id')

if [[ "$focused_ws" == "null" || -z "$focused_ws" ]]; then
  echo "No focused window / empty workspace." >&2
  exit 1
fi

# Collect IDs of tiled (non-floating) windows on this workspace, in order
mapfile -t window_ids < <(
  niri msg --json windows | jq -r --argjson ws "$focused_ws" \
    '[.[] | select(.workspace_id == $ws and .is_floating == false)] | sort_by(.id) | .[].id'
)

count="${#window_ids[@]}"

if [[ "$count" -eq 0 ]]; then
  echo "No tiled windows on current workspace." >&2
  exit 1
fi

pct=$(( 100 / count ))
remainder=$(( 100 - pct * count ))  # e.g. 1% leftover for 3 windows → last gets 34%

echo "Found $count tiled window(s) on workspace $focused_ws — setting each to ${pct}% width."

# Focus first window before resizing so layout starts from the left
niri msg action focus-window --id "${window_ids[0]}"

# Resize all windows in order; last window absorbs any remainder
last_idx=$(( count - 1 ))
for i in "${!window_ids[@]}"; do
  id="${window_ids[$i]}"
  niri msg action focus-window --id "$id"
  if [[ "$i" -eq "$last_idx" ]]; then
    niri msg action set-column-width "$(( pct + remainder ))%"
  else
    niri msg action set-column-width "${pct}%"
  fi
done

# Restore original focus
if [[ "$original_focus" != "null" && -n "$original_focus" ]]; then
  niri msg action focus-window --id "$original_focus"
fi