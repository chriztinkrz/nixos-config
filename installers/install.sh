mkdir -p ~/Pictures/Pictures/wallpapers
nix-shell -p git --run "git clone https://github.com/chriztinkrz/nixos-config.git ~/nixos-config"
nix-shell -p git --run "git clone https://github.com/chriztinkrz/wallpapers.git ~/Pictures/Pictures/wallpapers"
cd ~/nixos-config
sudo nixos-generate-config --show-hardware-config > ./configs/hardware/hardware.nix
git add .
sudo nixos-rebuild switch --flake .#common
nix-shell -p hellwal imagemagick --run "
  ln -sf ~/Pictures/Pictures/wallpapers/wallhaven-0j81gq.jpg $HOME/.cache/current_wallpaper.png
  hellwal -i ~/Pictures/Pictures/wallpapers/wallhaven-0j81gq.jpg
  cat "$HOME/.cache/hellwal/zed.json" > "$HOME/.config/zed/settings.json"
  touch "$HOME/.config/zed/settings.json"
"
