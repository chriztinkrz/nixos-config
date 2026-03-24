#!/usr/bin/env bash

if [ ! -d "$HOME/nixos-config" ]; then
    nix-shell -p git --run "git clone https://github.com/chriztinkrz/nixos-config.git ~/nixos-config"
else
    cd ~/nixos-config && nix-shell -p git --run "git pull" && cd ..
fi
if [ ! -d "$HOME/Pictures/Pictures/wallpapers" ]; then
    mkdir -p ~/Pictures/Pictures/wallpapers
    nix-shell -p git --run "git clone https://github.com/chriztinkrz/wallpapers.git ~/Pictures/Pictures/wallpapers"
else
    cd ~/Pictures/Pictures/wallpapers && nix-shell -p git --run "git pull" && cd ..
fi

cd ~/nixos-config
mkdir -p configs
sudo nixos-generate-config --show-hardware-config > ./configs/hardware-configuration.nix
nix-shell -p git --run "git add -f configs/hardware-configuration.nix && git add ."
sudo nixos-rebuild switch --flake .#nixosbtw
nix-shell -p swww hellwal imagemagick --run "
  # Run cache generator
  chmod +x ~/nixos-config/home-manager/hypr/scripts/install_wallpaper_cache.sh
  ~/nixos-config/home-manager/hypr/scripts/install_wallpaper_cache.sh

  # Force the Wayland environment variable so swww doesn't panic
  export WAYLAND_DISPLAY=wayland-1 
  
  pkill swww-daemon || true
  swww-daemon & 
  
  # Wait and Set
  for i in {1..5}; do
    if swww query >/dev/null 2>&1; then
      swww img ~/Pictures/Pictures/wallpapers/fluid2.jpg --transition-type grow
      break
    fi
    sleep 1
  done

  ln -sf ~/Pictures/Pictures/wallpapers/fluid2.jpg \$HOME/.cache/current_wallpaper.png
  hellwal -i ~/Pictures/Pictures/wallpapers/fluid2.jpg
"