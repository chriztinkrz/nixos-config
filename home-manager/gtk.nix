{ pkgs, ... }:

{
  home.packages = with pkgs; [
    adwaita-icon-theme
    adw-gtk3            # Ensure it's available to HM
    # your custom comixcursors is already in systemPackages, so HM can see it
  ];

  gtk = {
    enable = true;
    
    # 1. Use adw-gtk3 (Dark version)
    theme = {
      name = "adw-gtk3-dark"; 
      package = pkgs.adw-gtk3;
    };

    # 2. Keep Adwaita Icons (usually looks best with adw-gtk3)
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  # 3. Use your Comix Cursors
  home.pointerCursor = {
    # Replace "Adwaita" with the actual folder name inside your comixcursors package
    # Usually "ComixCursors-Black" or similar. Run `ls` on the path below to verify:
    # ls /run/current-system/sw/share/icons/
    name = "ComixCursors-Black"; 
    package = pkgs.comixcursors; # This refers to your custom derivation
    size = 24;
    gtk.enable = true;
    x11.enable = true; # Critical for some apps and window managers
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}