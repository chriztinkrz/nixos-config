{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../silentsddm/sddm.nix
      ./packages.nix
    ];

  nix.nixPath = [
  "nixos-config=/home/chriz/nixos-config/configs/configuration.nix"
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

  # configure keymap in x11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # flatpak
  # services.flatpak = {
  # enable = true;
    # packages = [
    # "app.zen_browser.zen" 
    # ];
    # update.auto.enable = true;
    # update.auto.onCalendar = "daily";
    # uninstallUnmanaged = true;
    # };

  # appimage
  # programs.appimage.enable = true;
  # programs.appimage.binfmt = true;
  # programs.appimage.package = pkgs.appimage-run.override 
   # {
      # extraPkgs = pkgs: 
    # [
      # pkgs.icu
      # pkgs.libxcrypt-legacy
      # pkgs.python312
      # pkgs.python312Packages.torch
  # ]; 
# };

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
  programs.xwayland.enable = true;
  services.blueman.enable = true;
  programs.dconf.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  programs.fish.enable = true;

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

  # no need to change this ig
  system.stateVersion = "25.11"; 

}