#!/usr/bin/env bash

WALL_DIR="$HOME/Pictures/Pictures/wallpapers"
THUMB_DIR="$HOME/.cache/wallthumbs"
CACHE_FILE="$HOME/.cache/wall_rofi_list.txt"
LOCK_FILE="/tmp/wall_gen.lock"
mkdir -p "$THUMB_DIR"

# --- 1. ATOMIC CACHE GENERATOR (Improved) ---
generate_list() {
    if [ -f "$LOCK_FILE" ]; then return; fi
    touch "$LOCK_FILE"

    local tmp_cache="${CACHE_FILE}.tmp"
    
    # We scan the directory fresh every time to ensure deleted files are gone
    find "$WALL_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) -printf "%T@ %f\n" | \
    sort -n | \
    cut -d' ' -f2- | \
    while read -r name; do
        full_path="$WALL_DIR/$name"
        hash=$(cksum <<< "$full_path" | cut -f1 -d' ')
        thumb="$THUMB_DIR/$hash.jpg"
        
        echo "$name|$thumb"
        
        # Only generate the thumbnail if it's missing
        if [ ! -f "$thumb" ]; then
            magick "$full_path" -thumbnail 300x300^ -gravity center -extent 300x300 "$thumb" >/dev/null 2>&1
        fi
    done > "$tmp_cache"

    mv "$tmp_cache" "$CACHE_FILE"

    # OPTIONAL: Cleanup orphaned thumbnails (files in cache folder that aren't in the list)
    # find "$THUMB_DIR" -type f -not -name "$(cut -d'|' -f2 "$CACHE_FILE" | xargs -I{} basename {})" -delete 2>/dev/null

    rm "$LOCK_FILE"
}

# --- 2. INITIAL CHECK ---
if [ ! -f "$CACHE_FILE" ]; then
    generate_list
fi

# --- 3. LAUNCH ROFI ---
last_row=$(($(wc -l < "$CACHE_FILE") - 1))
chosen=$(awk -F'|' '{printf "%s\0icon\x1f%s\n", $1, $2}' "$CACHE_FILE" | \
    rofi -dmenu -i \
    -selected-row "$last_row" \
    -show-icons \
    -kb-move-char-back 'Ctrl+Z'\
    -kb-move-char-forward 'Ctrl+X' \
    -kb-row-up 'Left' \
    -kb-row-down 'Right' \
    -theme-str '
    window { 
    width: 97.5%; 
    location: south; 
    anchor: south; 
    margin: 10px; 
}
    listview { 
    lines: 1; 
    columns: 10; 
    fixed-height: true; 
}
    element { 
    orientation: vertical; 
    children: [ element-icon ]; 
}
    element-icon { 
    size: 175px; 
    horizontal-align: 0.5; 
}
    element-text { 
    enabled: false; 
}
    inputbar { 
    enabled: false; 
} 

')

# --- 4. EXECUTE SELECTION ---
if [ -n "$chosen" ]; then
    full="$WALL_DIR/$chosen"
    swww img "$full" --transition-type grow --transition-duration 2 &
    (
        ln -sf "$full" "$HOME/.cache/current_wallpaper.png"
        hellwal -i "$full"
        pkill -USR1 cava
        pkill -USR2 btop
        makoctl reload
        blurred_wall="$HOME/.cache/blurred_wallpaper.png"
        magick "$full" -blur 0x5 "$blurred_wall"
        swww img -n overlay "$blurred_wall" --transition-type grow
    ) &
fi

# --- 5. BACKGROUND REFRESH ---
generate_list &