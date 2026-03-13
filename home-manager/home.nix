{ config, lib, pkgs, ... }:

/*
let
  homeDir = "/home/chriz";
  dotfiles = "${homeDir}/nixos-config/home-manager/dotfiles";
  hellCache = "${homeDir}/.cache/hellwal";
in */

{
  imports = [
    ./zen.nix
    ./git.nix
  ];

  /* xdg.configFile = {
    "fastfetch".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/fastfetch";
    "fish".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/fish";
    "foot".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/foot";
    "gtk-3.0".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/gtk-3.0";
    "gtk-4.0".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/gtk-4.0";
    "hellwal".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/hellwal";
    "hypr".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/hypr";
    "input-remapper-2".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/input-remapper-2";
    "mako".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/mako";
    "mango".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/mango";
    "matugen".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/matugen";
    "niri".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/niri";
    "qt5ct".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/qt5ct";
    "qt6ct".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/qt6ct";
    "rofi".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/rofi";
    "vicinae".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/vicinae";
    "waybar".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/waybar";
    "avizo/config.ini".source = config.lib.file.mkOutOfStoreSymlink "/home/chriz/.cache/hellwal/avizo.ini";
    "btop/btop.conf".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/btop/btop.conf";
    "btop/themes/hellwal.theme".source = config.lib.file.mkOutOfStoreSymlink "${hellCache}/btop.theme";
  }; */

  home.username = "chriz";
  home.homeDirectory = "/home/chriz";
  home.stateVersion = "25.11";
}