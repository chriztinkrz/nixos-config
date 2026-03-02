#!/usr/bin/env bash

# 1. Fetch NixOS Options (filtered for names only)
options=$(nixos-option -r . 2>/dev/null | awk '{print $1}' | sed 's/\.$//' | sort -u)

# 2. Fetch Packages (using the fast -qaP flag)
packages=$(nix-env -f '<nixpkgs>' -qaP --description 2>/dev/null | awk '{print $1}')

# 3. Combine and Pipe to FZF
echo -e "$options\n$packages" | fzf \
  --prompt=" Nix Search > " \
  --header="Type to filter Packages & Options" \
  --layout=reverse \
  --border \
  --preview="echo {} | grep -q '\.' && nixos-option {} || nix-env -f '<nixpkgs>' -qa --description {}"