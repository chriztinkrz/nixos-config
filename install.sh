mkdir -p ~/Pictures/Pictures/wallpapers
nix-shell -p git --run "git clone https://github.com/chriztinkrz/nixos-config.git ~/nixos-config"
nix-shell -p git --run "git clone https://github.com/chriztinkrz/wallpapers.git ~/Pictures/Pictures/wallpapers"
cd ~/nixos-config
mkdir -p configs
sudo nixos-generate-config --show-hardware-config > ./configs/hardware-configuration.nix
git add -f configs/hardware-configuration.nix
git add .
sudo nixos-rebuild switch --flake .#nixosbtw
swww-daemon &
sleep 1
swww img /home/chriz/Pictures/Pictures/wallpapers/fluid2.jpg --transition-type grow --transition-duration 1.75
ln -sf /home/chriz/Pictures/Pictures/wallpapers/fluid2.jpg "$HOME/.cache/current_wallpaper.png"
hellwal -i /home/chriz/Pictures/Pictures/wallpapers/fluid2.jpg