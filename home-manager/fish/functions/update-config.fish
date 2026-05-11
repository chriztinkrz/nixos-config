function update-config --wraps='cd ~/Pictures/Pictures/wallpapers/ && git fetch origin && git reset --hard origin/main && cd ~/nixos-config && git fetch origin && git reset --hard origin/main' --description 'alias update-config=cd ~/Pictures/Pictures/wallpapers/ && git fetch origin && git reset --hard origin/main && cd ~/nixos-config && git fetch origin && git reset --hard origin/main'
    cd ~/Pictures/Pictures/wallpapers/ && git fetch origin && git reset --hard origin/main && cd ~/nixos-config && git fetch origin && git reset --hard origin/main $argv
end
