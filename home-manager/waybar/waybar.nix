{ config, pkgs, ... }:

{
  
  programs.waybar = {
    enable = true;
    systemd.enable = true; # Automatically starts waybar with your session
  };

  # 1. Main Configuration (JSON)
  # You can either use 'programs.waybar.settings' or link a file.
  # Linking the file is usually easier for big configs:
  xdg.configFile."waybar/config".source = ./config;

  # 2. Main Style (CSS)
  # This file will @import the colors.css that Matugen creates.
  xdg.configFile."waybar/style.css".source = ./style.css;

}