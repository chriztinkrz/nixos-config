{ config, pkgs, ... }:

{
  home.packages = [ pkgs.cava ];

  # 1. THE MAIN CONFIG FILE
  # CAVA looks for 'config' (no extension) in ~/.config/cava/
  xdg.configFile."cava/config".text = ''
    [general]
    # Keep your custom settings here
    framerate = 60
    autosens = 1
    bars = 0
    bar_width = 2
    bar_spacing = 1

    [input]
    # Pipewire is usually the best bet for NixOS/Niri
    method = pipewire
    source = auto

    [output]
    method = noncurses

    [color]
    # This tells CAVA to look for ~/.config/cava/themes/matugen
    # which we will manage via Matugen templates
    theme = matugen

    [smoothing]
    noise_reduction = 77
  '';

}