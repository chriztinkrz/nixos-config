# ❄️ chriztinkrz's nixos config

### install commands:
```bash
nix-shell -p git --run "git clone [https://github.com/chriztinkrz/nixos-config.git](https://github.com/chriztinkrz/nixos-config.git) ~/nixos-config"
cd ~/nixos-config
sudo nixos-generate-config --show-hardware-config > ./configs/hardware-configuration.nix
git add .
sudo nixos-rebuild switch --flake .#nixosbtw