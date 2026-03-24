#!/usr/bin/env bash

# Paths (Keep these identical to your main script)
WALL_DIR="$HOME/Pictures/Pictures/wallpapers"
THUMB_DIR="$HOME/.cache/wallthumbs"
CACHE_FILE="$HOME/.cache/wall_rofi_list.txt"
LOCK_FILE="/tmp/wall_gen.lock"

# Ensure directories exist
mkdir -p "$THUMB_DIR"
mkdir -p "$(dirname "$CACHE_FILE")"

# Exit if another instance is already running
if [ -f "$LOCK_FILE" ]; then
    echo "Cache generation already in progress. Exiting."
    exit 0
fi

touch "$LOCK_FILE"

# --- ATOMIC CACHE GENERATOR ---
echo "Updating wallpaper cache..."
tmp_cache="${CACHE_FILE}.tmp"

# Scan directory, sort by time, and generate thumbnails
find "$WALL_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) -printf "%T@ %f\n" | \
sort -n | \
cut -d' ' -f2- | \
while read -r name; do
    full_path="$WALL_DIR/$name"
    hash=$(cksum <<< "$full_path" | cut -f1 -d' ')
    thumb="$THUMB_DIR/$hash.jpg"
    
    echo "$name|$thumb"
    
    # Generate thumbnail only if missing
    if [ ! -f "$thumb" ]; then
        # Using magick (ImageMagick 7)
        magick "$full_path" -thumbnail 300x300^ -gravity center -extent 300x300 "$thumb" >/dev/null 2>&1
    fi
done > "$tmp_cache"

# Atomically move the new cache into place
mv "$tmp_cache" "$CACHE_FILE"

# Clean up
rm "$LOCK_FILE"
echo "Done! Cache updated at $CACHE_FILE"