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

  # kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # boot thingies
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = [ "amdgpu" ];

  # required for boot entry label ig?
  system.nixos.label = let
  label = builtins.getEnv "NIXOS_LABEL";
  in if label != "" then label else "unlabeled";

  # plymouth
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
    initrd.verbose = false;
  };

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

  # disable suspend on lid close
  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
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

  /* flatpak
  services.flatpak = {
  enable = true;
    packages = [
    "app.zen_browser.zen" 
  ];
    update.auto.enable = true;
    update.auto.onCalendar = "daily";
    uninstallUnmanaged = true;
  };

  appimage
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
  }; */

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
  programs.fish = {
  enable = true;
  shellAliases = {
    # remove nixswitch from here if it's still there
  };
  interactiveShellInit = ''
  function nixswitch
    set label $argv[1]
    set dt (date "+%I:%M%p")

    if test -z "$label"
      set full_label "$dt"
    else
      set safe_label (string replace -ar '[^a-zA-Z0-9:_.-]' '_' $label)
      set full_label "$dt"_"$safe_label"
    end

    cd ~/nixos-config
    git add -A
    NIXOS_LABEL="$full_label" sudo --preserve-env=NIXOS_LABEL nixos-rebuild switch --flake .#nixosbtw --impure
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
    password = "9027q";
    packages = with pkgs; [
    ];
  };

  # no need to change this ig
  system.stateVersion = "25.11"; 

}