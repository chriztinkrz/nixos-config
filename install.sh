mkdir -p ~/Pictures/Pictures/wallpapers
nix-shell -p git --run "git clone https://github.com/chriztinkrz/nixos-config.git ~/nixos-config"
nix-shell -p git --run "git clone https://github.com/chriztinkrz/wallpapers.git ~/Pictures/Pictures/wallpapers"
cd ~/nixos-config
mkdir -p configs
sudo nixos-generate-config --show-hardware-config > ./configs/hardware-configuration.nix
git add .
sudo nixos-rebuild switch --flake .#nixosbtw