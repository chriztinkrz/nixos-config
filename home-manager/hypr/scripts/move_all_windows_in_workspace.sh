#!/usr/bin/env bash

# 1. Get current workspace
SOURCE_WS=$(hyprctl activeworkspace -j | jq -r '.id')

# 2. Handle Relative Logic (+1 / -1)
TARGET=$1
if [[ "$TARGET" == "+1" || "$TARGET" == "-1" ]]; then
    TARGET_WS=$((SOURCE_WS ${TARGET:0:1} ${TARGET:1}))
else
    TARGET_WS=$TARGET
fi

if [ "$TARGET_WS" -lt 1 ]; then TARGET_WS=1; fi

# 3. THE FIX: Get windows AND their X-coordinates, then sort by X
# This ensures we move them from left-to-right
WINS=$(hyprctl clients -j | jq -r ".[] | select(.workspace.id == $SOURCE_WS) | [.at[0], .address] | @tsv" | sort -n | cut -f2)

# 4. Move them in order
for ADDR in $WINS; do
    # Using -- to ensure -1 isn't treated as a flag
    hyprctl -- dispatch movetoworkspacesilent "$TARGET_WS,address:$ADDR"
done

# 5. Follow the move
hyprctl dispatch workspace "$TARGET_WS"