{ config, pkgs, inputs, ... }:

{

  # user packages which have programs option
  programs.niri.enable = true;
  programs.niri.useNautilus = true;
  programs.gpu-screen-recorder.enable = true;
  programs.foot.enable = true;
  programs.hyprlock.enable = true;
  services.input-remapper.enable = true; # small exception 👍🏻
  programs.hyprland.enable = true;

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # openssl is required for some package but exceeded eol, only package which requires compiling
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];

  # arduino
  services.udev.packages = [ pkgs.arduino-ide ];

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
    pname = "comixcursors";
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
      fzf
      nix-search-tv
    ];
    # reads existing script from nix-search-tv package
    text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
  })

  xdg-desktop-portal-gnome
  xdg-desktop-portal-gtk
  cliphist
  nautilus
  swww
  playerctl
  ffmpegthumbnailer
  bluez
  choose
  fd
  cnijfilter2
  adw-gtk3
  adwaita-qt
  adwaita-qt6
  gnome-themes-extra
  libadwaita
  loupe
  xsel
  brightnessctl
  tty-clock
  imagemagick
  mpv
  gammastep
  wl-clipboard
  pulseaudio
  sublime4
  killall
  gpu-screen-recorder
  yt-dlp
  libnotify
  comixcursors
  hellwal
  avizo
  btop
  cava
  fastfetch
  mako
  matugen
  waybar
  input-remapper
  polkit_gnome
  hyprshot
  jq
  inkscape

  ];

}