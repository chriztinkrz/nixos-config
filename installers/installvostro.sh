mkdir -p ~/Pictures/Pictures/wallpapers
nix-shell -p git --run "git clone https://github.com/chriztinkrz/nixos-config.git ~/nixos-config"
nix-shell -p git --run "git clone https://github.com/chriztinkrz/wallpapers.git ~/Pictures/Pictures/wallpapers"
cd ~/nixos-config
sudo nixos-generate-config --show-hardware-config > ./configs/hardware_vostro.nix
git add .
sudo nixos-rebuild switch --flake .#vostro
nix-shell -p swww hellwal imagemagick --run "
  ln -sf ~/Pictures/Pictures/wallpapers/fluid2.jpg $HOME/.cache/current_wallpaper.png
  hellwal -i ~/Pictures/Pictures/wallpapers/fluid2.jpg
"