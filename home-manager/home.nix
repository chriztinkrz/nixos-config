{ config, lib, pkgs, ... }:

let
  homeDir = "/home/chriz";
  configDirectory = "${homeDir}/nixos-config/home-manager/";
  hellwalCache = "${homeDir}/.cache/hellwal";
in

{
  imports = [
    ./zen.nix
    ./git.nix
    ./gtk.nix
    ./micro.nix
    # ./zed.nix
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
    "niri/config.kdl".source = config.lib.file.mkOutOfStoreSymlink "${configDirectory}/niri/config.kdl";
    "qt6ct".source = config.lib.file.mkOutOfStoreSymlink "${configDirectory}/qt6ct";
    "rofi".source = config.lib.file.mkOutOfStoreSymlink "${configDirectory}/rofi";
    "vicinae".source = config.lib.file.mkOutOfStoreSymlink "${configDirectory}/vicinae";
    "waybar".source = config.lib.file.mkOutOfStoreSymlink "${configDirectory}/waybar";
    "avizo/config.ini".source = config.lib.file.mkOutOfStoreSymlink "/home/chriz/.cache/hellwal/avizo.ini";
    "btop/btop.conf".source = config.lib.file.mkOutOfStoreSymlink "${configDirectory}/btop/btop.conf";
    "btop/themes/hellwal.theme".source = config.lib.file.mkOutOfStoreSymlink "${hellwalCache}/btop.theme";
    "niri/colors.kdl".source = config.lib.file.mkOutOfStoreSymlink "${hellwalCache}/niri.kdl";
    "niri/scripts/".source = config.lib.file.mkOutOfStoreSymlink "${configDirectory}/niri/scripts/";
    "qt5ct".source = config.lib.file.mkOutOfStoreSymlink "${configDirectory}/qt5ct";
    "zed/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${hellwalCache}/zed.json";
  };

  home.file = {
    ".cache/wall_order.txt".source = config.lib.file.mkOutOfStoreSymlink "/home/chriz/nixos-config/wall_script_cache/wall_order.txt";
    ".cache/wallthumbs".source = config.lib.file.mkOutOfStoreSymlink "/home/chriz/nixos-config/wall_script_cache/wallthumbs/";
  };

  home.username = "chriz";
  home.homeDirectory = "/home/chriz";
  home.stateVersion = "25.11";

}
