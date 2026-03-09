{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # 1. The rofi-power script
    (writeShellScriptBin "rofi-power" ''
      ${pkgs.rofi}/bin/rofi -show power \
        -modi "power:${pkgs.bash}/bin/bash /home/chriz/.config/rofi/scripts/rofi-power-menu" \
        -theme-str 'window { width: 11%; }'
    '')

    # 2. Rofi with plugins
    (rofi.override {
      plugins = [
        rofi-emoji
        rofi-calc
      ];
    })
  ];

  # 3. Mapping the entire Rofi folder
  # This will link everything (scripts, theme.rasi, config.rasi) in one go.
  xdg.configFile."rofi".source = ./.; 
}