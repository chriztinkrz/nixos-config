{ config, inputs, pkgs, lib, ... }: 

{  

  imports = [ inputs.silentSDDM.nixosModules.default ];

  # sddm itself
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = lib.mkForce true;
      settings.General.InputMethod = lib.mkForce ""; 
      extraPackages = with pkgs; [
        kdePackages.qtmultimedia
        kdePackages.qtsvg
        kdePackages.qt5compat
        ffmpeg
      ];
    };
    
    autoLogin = {
      enable = true;
      user = "chriz";
    };
  };

  # cursor shi
  services.xserver = {
    enable = true; # Necessary for SDDM to hook into input/fonts correctly
    xkb = {
      layout = "us";
      variant = "";
    };
  };
  services.displayManager.sddm.settings = {
    Theme = {
      CursorTheme = "ComixCursors-Black"; # Must match the folder name
    };
  };
  environment.variables = {
    XCURSOR_THEME = "ComixCursors-Black";
    XCURSOR_SIZE = "40";
    XCURSOR_PATH = lib.mkForce "/run/current-system/sw/share/icons:$HOME/.icons";
  };

  # silent sddm
  programs.silentSDDM = {
    enable = true;
    theme = "rei";
    settings = {
      General.animated-background-placeholder = "../../../../../../../../../${./rei3.png}";
      LockScreen = {
        background = "../../../../../../../../../${./rei3.mp4}";
        blur = 12;
      };
      "LockScreen.Clock" = {
        format = "h:mm AP";
        color = "#C0C0C0";
      };
      "LockScreen.Date".color = "#C0C0C0";
      "LockScreen.Message".display = true;
      "LoginScreen.LoginArea.Avatar" = {
        active-border-color = "#C0C0C0";
        inactive-border-color = "#C0C0C0";
      };
      "LoginScreen.LoginArea.Username".color = "#C0C0C0";
      "LoginScreen.LoginArea.PasswordInput" = {
        content-color = "#C0C0C0";
        border-color = "#C0C0C0";
      };
      "LoginScreen.LoginArea.LoginButton" = {
        background-color = "#C0C0C0";
        active-background-color = "#C0C0C0";
        content-color = "#C0C0C0";
        border-color = "#C0C0C0";
      };
      "LoginScreen.MenuArea.Popups" = {
        active-option-background-color = "#C0C0C0";
        content-color = "#C0C0C0";
        border-color = "#C0C0C0";
      };
      "LoginScreen.MenuArea.Session" = {
        content-color = "#C0C0C0";
        background-color = "#C0C0C0";
      };
      "LoginScreen.MenuArea.Layout" = {
        background-color = "#C0C0C0";
        content-color = "#C0C0C0";
      };
      "LoginScreen.MenuArea.Keyboard" .display = false;
      "LoginScreen.MenuArea.Power" = {
        background-color = "#C0C0C0";
        content-color = "#C0C0C0";
      };
      "LoginScreen.VirtualKeyboard" = {
        background-color = "#C0C0C0";
        key-content-color = "#C0C0C0";
        selection-background-color = "#000000";
        selection-content-color = "#C0C0C0";
        primary-color = "#C0C0C0";
        border-color = "#C0C0C0";
      };
      Tooltips.content-color = "#C0C0C0";
    };
  };
}