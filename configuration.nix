{ config, pkgs, inputs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      inputs.silentSDDM.nixosModules.default
    ];

  nix.nixPath = [
  "nixos-config=/home/chriz/nixos-config/configuration.nix"
  "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
];

  # bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # garbage collection
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # automatic upgrades
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
  };

  networking.hostName = "nixosbtw";
  networking.networkmanager.enable = true;

  # set your time zone.
  time.timeZone = "Asia/Muscat";

  # select internationalisation properties.
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

  # silent sddm theme ( finally )
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

  # sddm itself
  services.xserver.displayManager = {
    sddm = {
      enable = true;
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

  # configure keymap in x11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # flatpak
  #  services.flatpak = {
  #  enable = true;
  #  packages = [
  #  "app.zen_browser.zen" 
  #  ];
  #  update.auto.enable = true;
  #  update.auto.onCalendar = "daily";
  #  uninstallUnmanaged = true;
  #  };

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
  services.printing.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
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
  programs.niri.enable = true;
  programs.niri.useNautilus = true;
  programs.fish.enable = true;
  programs.fish.shellAliases = {
  nixswitch = "cd ~/nixos-config && sudo nix flake update --flake . && git add . && sudo nixos-rebuild switch --flake .#nixosbtw"; };
  programs.xwayland.enable = true;
  services.blueman.enable = true;

  # user account
  users.users.chriz = {
    isNormalUser = true;
    description = "chriz";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    password = "9027q";
    packages = with pkgs; [
    ];
  };

  # packages which have programs option
  programs.foot.enable = true;
  programs.hyprlock.enable = true;
  programs.gpu-screen-recorder.enable = true;

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

# fonts
  fonts.packages = with pkgs; [
    inter
    hermit
    noto-fonts
    noto-fonts-cjk-sans
    nerd-fonts.symbols-only
    fira-code
    fira-code-symbols
    noto-fonts-color-emoji
    redhat-official-fonts
    adwaita-fonts

    # gravitas one
    (pkgs.runCommand "gravitas-one" { } ''
      mkdir -p $out/share/fonts/truetype
      cp ${pkgs.fetchurl {
        url = "https://github.com/google/fonts/raw/main/ofl/gravitasone/GravitasOne.ttf";
        sha256 = "sha256-tA3EXzNU8oIQcoas8VQgctJYxxfI7fHRGO8BBfJeYns=";
      }} $out/share/fonts/truetype/GravitasOne.ttf
    '')

  ];

  # packages
  environment.systemPackages = with pkgs; [

  # rofi-power
  (pkgs.writeShellScriptBin "rofi-power" ''
    ${pkgs.rofi}/bin/rofi -show power -modi "power:${pkgs.bash}/bin/bash /home/chriz/.config/rofi/scripts/rofi-power-menu" -theme-str 'window { width: 11%; }'
  '')

    # rofi external modes
  ( rofi.override {
      plugins = [
         rofi-emoji
         rofi-calc
      ];
    })

  # comix cursors
  (pkgs.stdenv.mkDerivation rec {
    pname = "comix-cursors";
    version = "0.10.1";
    src = pkgs.fetchurl {
      url = "https://limitland.gitlab.io/comixcursors/ComixCursors-${version}.tar.bz2";
      sha256 = "sha256-UdgXOGmLsgBjRwy9XouXvxL+2r+Nwn/8zD+V4JwBWcI=";
    };
    sourceRoot = ".";
    installPhase = ''
      mkdir -p $out/share/icons
      cp -r * $out/share/icons/
    '';
  })

  # create an fhs environment using the command `fhs`, enabling the execution of non-nixos packages in nixos
    (let base = pkgs.appimageTools.defaultFhsEnvArgs; in
      pkgs.buildFHSEnv (base // {
      name = "fhs";
      targetPkgs = pkgs:

        # pkgs.buildFHSEnv provides only a minimal FHS environment lacking many basic packages needed by most software.
        # pkgs.appimageTools provides basic packages required by most software.

        (base.targetPkgs pkgs) ++ (with pkgs; [
          pkg-config
          ncurses

          # add more if needed

        ]
      );
      profile = "export FHS=1";
      runScript = "bash";
      extraOutputsToInstall = ["dev"];
    }))

  # ns - package search
  (pkgs.writeShellApplication {
    name = "ns"; # command name
    runtimeInputs = with pkgs; [
      nix-search-tv
    ];
    # reads existing script from nix-search-tv package
    text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
  })

  xdg-desktop-portal-gnome
  xdg-desktop-portal-gtk
  cliphist
  nautilus
  fastfetch
  matugen
  swww
  avizo
  playerctl
  waybar
  ffmpegthumbnailer
  bluez
  choose
  fd
  cnijfilter2
  adw-gtk3
  adwaita-qt
  adwaita-qt6
  cava
  gnome-themes-extra
  libadwaita
  loupe
  mako
  xsel
  brightnessctl
  tty-clock
  imagemagick
  mpv
  gammastep
  wl-clipboard
  git
  pulseaudio
  sublime4
  btop
  killall
  gpu-screen-recorder
  yt-dlp
  libnotify
  jq
  fzf

  ];

  # openssl is required for some package but exceeded eol, only package which requires compiling
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];

  # no need to change this ig
  system.stateVersion = "25.11"; 

}