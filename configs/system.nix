{ config, pkgs, inputs, ... }:

{

  # kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # boot thingies
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # required for boot entry label ig?
  system.nixos.label = let
  label = builtins.getEnv "NIXOS_LABEL";
  in if label != "" then label else "unlabeled";

  # mac-style-plymouth
  boot = {
    plymouth = {
      enable = true;
      theme = "mac-style";
      themePackages = with pkgs; [ mac-style-plymouth ];
    };
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];

    consoleLogLevel = 0;
  };

  /* nixos wiki plymouth
  boot = {
    plymouth = {
      enable = true;
      theme = "lone";
      themePackages = [
        (pkgs.adi1090x-plymouth-themes.override {
          selected_themes = [ "lone" ];
        })
      ];
    };
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    consoleLogLevel = 0;
  }; */

  # garbage collection and nh
  programs.nh = {
    enable = true;
    flake = "/home/chriz/nixos-config";
    clean = {
      enable = true;
      extraArgs = "--keep 100";
      dates = "hourly";
    };
  };
  nix.settings.auto-optimise-store = true;

  # disable suspend on lid close
  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };

  # speed up shut down things
  systemd.settings.Manager = {
    DefaultTimeoutStopSec = "10s";
  };
  services.logind.settings.Login = {
    KillUserProcesses = true;
  };

  networking.hostName = "nixosbtw";
  networking.networkmanager.enable = true;

  # set your time zone.
  time.timeZone = "Asia/Muscat";

  # internationalisation properties
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # configure keymap in x11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  /* flatpak
  services.flatpak = {
    enable = true;
    packages = [
      "ch.tlaun.TL"
    ];
    update.auto.enable = true;
    update.auto.onCalendar = "daily";
    uninstallUnmanaged = true;
    }; */

  # appimage
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  programs.appimage.package = pkgs.appimage-run.override
  {
    extraPkgs = pkgs:
    [
      pkgs.icu
      pkgs.libxcrypt-legacy
      pkgs.python312
      pkgs.python312Packages.torch
    ];
  };

  # system stuff
  programs.sway = {
    enable = true;
    package = pkgs.swayfx;
  };
  # hy3
  environment.etc."hypr/plugins.conf".text = ''
    plugin = ${pkgs.hyprlandPlugins.hy3}/lib/libhy3.so
  '';
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.printing = {
    enable = true;
    drivers = [ pkgs.canon-cups-ufr2 ];
    extraConf = ''
      DefaultOption PrintQuality High
      DefaultOption Resolution 600dpi
    '';
  };
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        ControllerMode = "dual";
        Experimental = true;
        JustWorksRepairing = "always";
      };
    };
  };
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;
  programs.xwayland.enable = true;
  services.blueman.enable = true;
  programs.dconf.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1"; # for vscode?
  programs.fish = {
  enable = true;
  interactiveShellInit = ''
    function nixswitch
      set label ""
      set host "nixosbtw"

      set i 1
      while test $i -le (count $argv)
        switch $argv[$i]
          case "-c"
            set host "common"
          case "-e"
            set host "nixosbtw"
          case "-v"
            set host "vostro"
          case "*"
            set label $argv[$i]
        end
        set i (math $i + 1)
      end

      set dt (date "+%I:%M%p")
      if test -z "$label"
        set full_label "$dt"
      else
        set safe_label (string replace -a -r -- '[^a-zA-Z0-9:_.-]' '_' $label)
        set full_label "$dt"_"$safe_label"
      end

      cd ~/nixos-config
      git add -A
      NIXOS_LABEL="$full_label" sudo --preserve-env=NIXOS_LABEL nixos-rebuild switch --flake .#$host --impure
    end
'';
};

  # user account
  users.users.chriz = {
    isNormalUser = true;
    description = "chriz";
    extraGroups = [
    "networkmanager"
    "wheel"
    "uucp"
    "lock"
    "dialout"
    ];
    shell = pkgs.fish;
  };

  # no need to change this ig
  system.stateVersion = "25.11";

}
