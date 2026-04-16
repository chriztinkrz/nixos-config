{ config, pkgs, inputs, ... }:
{
  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # user packages which have programs option
  programs.niri.enable = true;
  programs.niri.useNautilus = true;
  programs.gpu-screen-recorder.enable = true;
  programs.foot.enable = true;
  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;
  programs.waybar.enable = true;
  programs.steam.enable = true;
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      vulkan-loader
      libvdpau
      libva
      libxmu
      libGL
      libGLU
      libx11
      libxext
      libxrandr
      libxinerama
      libxcursor
      libxi
      glib
      zlib
      alsa-lib
      (pkgs.runCommand "steamrun-lib" {} "mkdir $out; ln -s ${pkgs.steam-run.fhsenv}/usr/lib64 $out/lib")
    ];
  };

  /* plotter things
  services.udev.packages = with pkgs; [ arduino-ide ugs ]; */

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
    dejavu_fonts
    liberation_ttf
    aileron

    # gravitas one
    (pkgs.runCommand "gravitas-one" { } ''
      mkdir -p $out/share/fonts/truetype
      cp ${pkgs.fetchurl {
        url = "https://github.com/google/fonts/raw/main/ofl/gravitasone/GravitasOne.ttf";
        sha256 = "sha256-tA3EXzNU8oIQcoas8VQgctJYxxfI7fHRGO8BBfJeYns=";
      }} $out/share/fonts/truetype/GravitasOne.ttf
    '')

  ];
  fonts.fontconfig.enable = true;

  # packages
  environment.systemPackages = with pkgs; [

  /* svg2gcode
  (rustPlatform.buildRustPackage rec {
      pname = "svg2gcode-cli";
      version = "0.0.18";
      src = pkgs.fetchurl {
        name = "${pname}-${version}.tar.gz";
        url = "https://crates.io/api/v1/crates/${pname}/${version}/download";
        hash = "sha256-8MKaWeJzu1cFl8H/PQbJU+EWntbFqJtq+/exSFnezso=";
      };
      cargoHash = "sha256-txGRVby8MUzycgYY8OYXU6OIt9PBUDyFFHPWysp0KCI=";
      nativeBuildInputs = [ pkg-config ];
      buildInputs = [ openssl ];
    }) */

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
    }
  )

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

  (pkgs.writeShellScriptBin "hypr-screenshot" ''
    MODE=$1
    DIR=~/Pictures/Screenshots
    FILE="$DIR/$(date +'%d.%m.%Y %I:%M:%S %p').png"
    mkdir -p "$DIR"

    case "$MODE" in
      output)
        ${pkgs.grim}/bin/grim -o eDP-1 -s 0.83 "$FILE"
        ;;
      region)
        ${pkgs.wayfreeze}/bin/wayfreeze &
        FREEZE_PID=$!
        sleep 0.1
        GEOM=$(${pkgs.slurp}/bin/slurp)
        sleep 0.1
        ${pkgs.grim}/bin/grim -s 0.83 -g "$GEOM" "$FILE"
        kill $FREEZE_PID
        ;;
      window)
        GEOM=$(${pkgs.hyprland}/bin/hyprctl activewindow -j | ${pkgs.jq}/bin/jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
        ${pkgs.grim}/bin/grim -s 0.83 -g "$GEOM" "$FILE"
        ;;
    esac

    # --- Copy to Clipboard ---
    if [ -f "$FILE" ]; then
      ${pkgs.wl-clipboard}/bin/wl-copy < "$FILE"
      ${pkgs.libnotify}/bin/notify-send "Screenshot" "$MODE captured & copied to clipboard" -i "$FILE"
    fi
  '')

  # normal packages
  xdg-desktop-portal-gnome
  xdg-desktop-portal-gtk
  cliphist
  nautilus
  awww
  playerctl
  ffmpegthumbnailer
  bluez
  choose
  fd
  adw-gtk3
  adwaita-qt
  adwaita-qt6
  adwaita-icon-theme
  gnome-themes-extra
  libadwaita
  loupe
  xsel
  brightnessctl
  tty-clock
  imagemagick
  ghostscript # for pdf conversion with imagemagick
  mpv
  gammastep
  wl-clipboard
  pulseaudio
  killall
  gpu-screen-recorder
  yt-dlp
  libnotify
  comixcursors.Opaque_Black
  hellwal
  avizo
  btop
  cava
  fastfetch
  mako
  jq
  pavucontrol
  zed-editor
  nixd
  nixpkgs-fmt
  steam-run
  tree
  grim
  slurp
  quickshell
  qt6.qt5compat
  qt6.qtwayland
  fzf
  wayfreeze

  /* these both are required for input-remapper along with the service
  input-remapper
  polkit_gnome */

  /* plotter thingies
  arduino-ide
  inkscape */

  ]++ (import ./legacy_launcher/legacy_launcher.nix { inherit pkgs; });
}
