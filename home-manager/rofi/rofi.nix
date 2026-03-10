{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # rofi-power
    (writeShellScriptBin "rofi-power" ''
      ${pkgs.rofi}/bin/rofi -show power \
        -modi "power:${pkgs.bash}/bin/bash ${config.home.homeDirectory}/.config/rofi/scripts/rofi-power-menu" \
        -theme-str 'window { width: 11%; }'
    '')

    # 2. other rofi modes
    (rofi.override {
      plugins = [
        rofi-emoji
        rofi-calc
      ];
    })
  ];

  xdg.configFile."rofi/config.rasi".source = ./config.rasi;
  xdg.configFile."rofi/scripts".source = ./scripts;

}