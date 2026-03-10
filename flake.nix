{
  description = "flake config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # YOUR ACTUAL SYSTEM
    nixosConfigurations.nixosbtw = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configs/system.nix
        inputs.nix-flatpak.nixosModules.nix-flatpak
        inputs.silentSDDM.nixosModules.default
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.chriz = import ./home-manager/home.nix;
        }
      ];
    };

    # THE CUSTOM ISO
    nixosConfigurations.iso = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
        ./configs/system.nix
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          
          # FIXED: Merged into one definition
          home-manager.users.nixos = {
            imports = [ ./home-manager/home.nix ];
            home.username = "nixos";
            home.homeDirectory = "/home/nixos";
          };

          # Force disable graphical login on ISO
          services.displayManager.sddm.enable = nixpkgs.lib.mkForce false;
          nix.settings.experimental-features = [ "nix-command" "flakes" ];
        }
      ];
    };
  };
}