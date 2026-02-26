{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
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

  networking.hostName = "nixosbtw"; # define your hostname.

  # enable networking
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

  # sddm
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  # sddm autologin
  services.displayManager.autoLogin = {
    enable = true;
    user = "chriz";
  };

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
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
  services.flatpak.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;
  programs.niri.enable = true;
  programs.niri.useNautilus = true;
  programs.fish.enable = true;
  programs.fish.shellAliases = {
    nixswitch = "sudo nixos-rebuild switch"; };
  programs.fish.shellAliases = {
    update = "sudo nix-channel --update && sudo nixos-rebuild switch"; };
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
    #  thunderbird
    ];
  };

  # apps which have programs option
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
  ];

  # rofi-power-menu and packages from nixpkgs
  environment.systemPackages = with pkgs; [
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

  alacritty
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
  rofi-power-menu
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
  nwg-look
  pavucontrol
  unimatrix
  xsel
  brightnessctl
  tty-clock
  fzf
  imagemagick
  upscayl
  mpv
  gammastep
  font-awesome
  meson
  wl-clipboard
  git
  pulseaudio
  sublime4
  btop
  killall
  adwaita-fonts
  gpu-screen-recorder
  nitch

  ];

  # openssl is required for some package but exceeded eol, only package which requires compiling
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];

  # no need to change this ig
  system.stateVersion = "25.11"; 

}