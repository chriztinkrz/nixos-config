{ config, lib, pkgs, ... }:

let
  homeDir = "/home/chriz";
  configDirectory = "${homeDir}/nixos-config/home-manager/";
  hellCache = "${homeDir}/.cache/hellwal";
in

{
  imports = [
    ./zen.nix
    ./git.nix
    ./gtk.nix
  ];

  xdg.configFile = {
    "fastfetch".source = config.lib.file.mkOutOfStoreSymlink "${configDirectory}/fastfetch";
    "fish".source = config.lib.file.mkOutOfStoreSymlink "${configDirectory}/fish";
    "foot".source = config.lib.file.mkOutOfStoreSymlink "${configDirectory}/foot";
    "hellwal".source = config.lib.file.mkOutOfStoreSymlink "${configDirectory}/hellwal";
    "hypr".source = config.lib.file.mkOutOfStoreSymlink "${configDirectory}/hypr";
    "input-remapper-2".source = config.lib.file.mkOutOfStoreSymlink "${configDirectory}/input-remapper-2";
    "mako".source = config.lib.file.mkOutOfStoreSymlink "${configDirectory}/mako";
    "mango".source = config.lib.file.mkOutOfStoreSymlink "${configDirectory}/mango";
    "matugen".source = config.lib.file.mkOutOfStoreSymlink "${configDirectory}/matugen";
    "niri".source = config.lib.file.mkOutOfStoreSymlink "${configDirectory}/niri";
    "qt5ct".source = config.lib.file.mkOutOfStoreSymlink "${configDirectory}/qt5ct";
    "qt6ct".source = config.lib.file.mkOutOfStoreSymlink "${configDirectory}/qt6ct";
    "rofi".source = config.lib.file.mkOutOfStoreSymlink "${configDirectory}/rofi";
    "vicinae".source = config.lib.file.mkOutOfStoreSymlink "${configDirectory}/vicinae";
    "waybar".source = config.lib.file.mkOutOfStoreSymlink "${configDirectory}/waybar";
    "avizo/config.ini".source = config.lib.file.mkOutOfStoreSymlink "/home/chriz/.cache/hellwal/avizo.ini";
    "btop/btop.conf".source = config.lib.file.mkOutOfStoreSymlink "${configDirectory}/btop/btop.conf";
    "btop/themes/hellwal.theme".source = config.lib.file.mkOutOfStoreSymlink "${hellCache}/btop.theme";
  };

  home.username = "chriz";
  home.homeDirectory = "/home/chriz";
  home.stateVersion = "25.11";
  
}