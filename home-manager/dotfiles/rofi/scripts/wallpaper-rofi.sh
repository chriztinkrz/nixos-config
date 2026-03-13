#!/usr/bin/env bash

WALL_DIR="$HOME/Pictures/Pictures/wallpapers"
THUMB_DIR="$HOME/.cache/wallthumbs"
mkdir -p "$THUMB_DIR"

entries=""

while IFS= read -r img; do
    name="$(basename "$img")"
    hash="$(printf "%s" "$img" | sha1sum | awk '{print $1}')"
    thumb="$THUMB_DIR/$hash.jpg"

    # Create thumbnail if missing
    if [ ! -f "$thumb" ]; then
        magick "$img" -thumbnail 300x300^ -gravity center -extent 300x300 "$thumb" 2>/dev/null &
    fi

    entries+="$(basename "$img")\x00icon\x1f$thumb\n"

done < <(find "$WALL_DIR" -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' \))

wait   # ensures thumbnails finish first run

chosen=$(printf "$entries" | rofi -dmenu -i \
    -show-icons \
    -kb-move-char-back 'Ctrl+Z' \
    -kb-move-char-forward 'Ctrl+X' \
    -kb-row-up 'Left' \
    -kb-row-down 'Right' \
    -theme-str '
window { 
    width: 97.5%; 
    padding: 0px; 
    location: south; 
    anchor: center; 
}
listview {
    lines: 1;
    columns: 10;
    spacing: 0px;
    layout: vertical;
    fixed-height: true;
}
element {
    padding: 0px;
    margin: 0px;
    orientation: vertical;
    children: [ element-icon ];
    expand: false;
}
element-text {
    enabled: false;
}
element-icon {
    size: 175px;
    margin: 0px;
    padding: 10px;
    horizontal-align: 0.5;
    vertical-align: 0.5;
}
inputbar {
enabled: false;
}

')

if [ -n "$chosen" ]; then
    full=$(find "$WALL_DIR" -type f -iname "$chosen" | head -n1)

    swww img "$full" --transition-type grow --transition-duration 2

    ln -sf "$full" "$HOME/.cache/current_wallpaper.png"

    matugen image "$full" --mode dark --type scheme-content
    (
        blurred_wall="$HOME/.cache/blurred_wallpaper.png"
        magick "$full" -blur 0x5 "$blurred_wall"
        swww img -n overlay "$blurred_wall" --transition-type grow

    ) &
    disown
fi
