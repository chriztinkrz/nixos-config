function update-config --wraps='cd ~/nixos-config && git fetch origin && git reset --hard origin/main && cd ~/Pictures/Pictures/wallpapers/ && git fetch origin && git reset --hard origin/main' --description 'update nixos-config, wallpapers after'
    cd ~/nixos-config && git fetch origin && git reset --hard origin/main; or return 1

    cd ~/Pictures/Pictures/wallpapers/ && git fetch origin && git reset --hard origin/main; or return 1

    cd - $argv
end
