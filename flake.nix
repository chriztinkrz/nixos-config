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
      inputs.home-manager.follows = "home-manager";
    };
    mac-style-plymouth = {
      url = "github:SergioRibera/s4rchiso-plymouth-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      mkSystem = extraModules: nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          { nixpkgs.hostPlatform = "x86_64-linux"; }
          ./configs/shared.nix
        ] ++ extraModules;
      };
    in {
      nixosConfigurations = {
        nixosbtw = mkSystem [
          ./configs/hardware/hardware.nix
          ./configs/hardware/elitebook.nix
          ./configs/hardware/laptop.nix
        ];

        vostro = mkSystem [
          ./configs/hardware/hardware_vostro.nix
          ./configs/hardware/laptop.nix
          ./configs/hardware/vostro.nix
        ];

        common = mkSystem [
          ./configs/hardware/hardware.nix
        ];
      };
    };
  }
