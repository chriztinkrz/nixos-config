{ inputs, pkgs, ... }: {

  imports = [
    ./system.nix
    ./silentsddm/sddm.nix
    ./packages.nix
    inputs.nix-flatpak.nixosModules.nix-flatpak
    inputs.home-manager.nixosModules.home-manager
    inputs.scroll-flake.nixosModules.default
  ];

  nixpkgs.overlays = [ inputs.mac-style-plymouth.overlays.default ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.chriz = import ../home-manager/home.nix;
    backupFileExtension = "backup";
  };

}
