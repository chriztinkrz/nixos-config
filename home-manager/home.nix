{ config, pkgs, inputs, ... }:

{
  imports = [
    ./zen.nix
    # ./niri/niri.nix
    # ./matugen/matugen.nix
    ./avizo.nix
    ./btop.nix
    # ./cava.nix
    # ./fastfetch.nix
    # ./fish/fish.nix
    # ./foot.nix
    # ./gtk-3.0.nix
    # ./gtk-4.0.nix
    # ./hyprlock.nix
    # ./mako.nix
    # ./rofi/rofi.nix
    # ./waybar/waybar.nix
  ];

  home.username = pkgs.lib.mkDefault "chriz";
  home.homeDirectory = pkgs.lib.mkDefault "/home/${config.home.username}";
  home.stateVersion = "25.11";

}