function power --wraps="rofi -show power -modi power:/home/chriz/.config/rofi/scripts/rofi-power-menu -theme-str 'window { width: 11%; }'" --description "alias power=rofi -show power -modi power:/home/chriz/.config/rofi/scripts/rofi-power-menu -theme-str 'window { width: 11%; }'"
    rofi -show power -modi power:/home/chriz/.config/rofi/scripts/rofi-power-menu -theme-str 'window { width: 11%; }' $argv
end
