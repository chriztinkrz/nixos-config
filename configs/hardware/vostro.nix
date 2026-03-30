{ config, pkgs, ... }:
{
# vostro 5471 fixes
  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;
  boot.initrd.kernelModules = [ "i915" ];
  services.xserver.videoDrivers = [ "modesetting" ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };
  boot.kernelParams = [ 
    "initcall_blacklist=amdgpu_init"
    "i915.enable_psr=0" 
    ];
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
    function nixswitchv
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
      NIXOS_LABEL="$full_label" sudo --preserve-env=NIXOS_LABEL nixos-rebuild switch --flake .#vostro --impure
    end
    '';
  };
}