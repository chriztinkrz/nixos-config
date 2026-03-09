{ config, pkgs, inputs, ... }:

{
  imports = [
    ./zen.nix
    ./niri/niri.nix
    ./matugen/matugen.nix
    ./avizo.nix
    ./btop/btop.nix
    ./cava.nix
    ./fastfetch.nix
  ];

  home.username = "chriz";
  home.homeDirectory = "/home/chriz";
  home.stateVersion = "25.11";
}