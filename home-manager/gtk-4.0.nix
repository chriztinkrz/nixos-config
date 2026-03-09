{ config, pkgs, ... }:

{
  xdg.configFile."gtk-4.0/settings.ini".text = ''

[Settings]
gtk-theme-name=adw-gtk3-dark
gtk-icon-theme-name=Adwaita
gtk-font-name=Adwaita Sans 11
gtk-cursor-theme-name=ComixCursors-Black
gtk-cursor-theme-size=24
gtk-application-prefer-dark-theme=1

  '';
}