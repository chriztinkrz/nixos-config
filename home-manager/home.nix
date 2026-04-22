{ config, lib, pkgs, ... }:

let
  homeDir = config.home.homeDirectory;
  configDirectory = "${homeDir}/nixos-config/home-manager/";
  hellwalCache = "${homeDir}/.cache/hellwal";
in

{
  imports = [
    ./zen.nix
    ./git/git.nix
    ./gtk.nix
    # ./sway.nix
  ];

  home.username = "chriz";
  home.homeDirectory = pkgs.lib.mkDefault "/home/${config.home.username}";
  home.stateVersion = "25.11";

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
    "avizo/config.ini".source = config.lib.file.mkOutOfStoreSymlink "${hellwalCache}/avizo.ini";
    "btop/btop.conf".source = config.lib.file.mkOutOfStoreSymlink "${configDirectory}/btop/btop.conf";
    "btop/themes/hellwal.theme".source = config.lib.file.mkOutOfStoreSymlink "${hellwalCache}/btop.theme";
    "niri/colors.kdl".source = config.lib.file.mkOutOfStoreSymlink "${hellwalCache}/niri.kdl";
    "niri/scripts/".source = config.lib.file.mkOutOfStoreSymlink "${configDirectory}/niri/scripts/";
    "qt5ct".source = config.lib.file.mkOutOfStoreSymlink "${configDirectory}/qt5ct";
    "sway".source = lib.mkForce (config.lib.file.mkOutOfStoreSymlink "${configDirectory}/sway");
  };

  home.file = {
    ".cache/wall_order.txt".source = config.lib.file.mkOutOfStoreSymlink "${configDirectory}/wall_script_cache/wall_order.txt";
    ".cache/wallthumbs".source = config.lib.file.mkOutOfStoreSymlink "${configDirectory}/wall_script_cache/wallthumbs/";
  };

}
