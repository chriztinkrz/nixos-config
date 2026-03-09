{ config, pkgs, lib, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      nixswitch = "cd ~/nixos-config && git add . || true && sudo nixos-rebuild switch --flake .#nixosbtw";
    };

    # 1. READ your custom config file into the Fish module
    # This prevents the conflict by merging your file with the Nix-generated one
    interactiveShellInit = lib.readFile ./other_stuff/config.fish;
  };

  # 2. Keep these - they don't conflict because the Fish module doesn't 
  # touch these specific sub-folders by default.
  xdg.configFile."fish/functions".source = ./other_stuff/functions;
  xdg.configFile."fish/conf.d".source = ./other_stuff/conf.d;
  xdg.configFile."fish/wal.fish".source = ./other_stuff/wal.fish;
}