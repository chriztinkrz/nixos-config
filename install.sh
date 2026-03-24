mkdir -p ~/Pictures/Pictures/wallpapers
nix-shell -p git --run "git clone https://github.com/chriztinkrz/nixos-config.git ~/nixos-config"
nix-shell -p git --run "git clone https://github.com/chriztinkrz/wallpapers.git ~/Pictures/Pictures/wallpapers"
cd ~/nixos-config
mkdir -p configs
sudo nixos-generate-config --show-hardware-config > ./configs/hardware-configuration.nix
git add -f configs/hardware-configuration.nix
git add .
sudo nixos-rebuild switch --flake .#nixosbtw
nix-shell -p swww hellwal imagemagick --run "
  ~/nixos-config/home-manager/hypr/scripts/install_wallpaper_cache.sh
  swww-daemon & 
  for i in {1..5}; do
    if swww query >/dev/null 2>&1; then
      swww img ~/Pictures/Pictures/wallpapers/fluid2.jpg --transition-type grow
      break
    fi
    sleep 1
  done
  ln -sf ~/Pictures/Pictures/wallpapers/fluid2.jpg $HOME/.cache/current_wallpaper.png
  hellwal -i ~/Pictures/Pictures/wallpapers/fluid2.jpg
"