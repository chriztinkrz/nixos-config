{ config, pkgs, ... }:

{
  gtk = {
    enable = true;

    # general theme and icon theme
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    # dark theme
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;

    gtk4.theme = config.gtk.theme;

  };

  # comixcursors
  home.pointerCursor = {
    name = "ComixCursors-Opaque-Black";
    package = pkgs.comixcursors.Opaque_Black;
    size = 28;
    gtk.enable = true;
    x11.enable = true; # needed for some apps
  };

  # dark theme but dconf basically
  dconf.settings = {
    "org/gnome/desktop/interface" = { color-scheme = "prefer-dark"; };
  };
}
