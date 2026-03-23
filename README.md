# ❄️ chriztinkrz's NixOS Config

### 🚀 Quick Install (Fresh System)
Run these commands to clone and apply the configuration:

```bash
# 1. Enter a shell with git and clone
nix-shell -p git --run "git clone [https://github.com/chriztinkrz/nixos-config.git](https://github.com/chriztinkrz/nixos-config.git) ~/nixos-config"

# 2. Sync hardware and switch
cd ~/nixos-config
sudo nixos-generate-config --show-hardware-config > ./configs/hardware-configuration.nix
git add .
sudo nixos-rebuild switch --flake .#nixosbtw