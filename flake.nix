{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    helium-flake = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, nixos-hardware, home-manager, helium-flake, ... }@inputs:
    let
      system = "x86_64-linux";
    in {

      # nixos - system hostname
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          pkgs-stable = import nixpkgs-stable {
            inherit system;
            config.allowUnfree = true;
          };
          inherit inputs system;
        };
        modules = [
          ./nixos/configuration.nix

          nixos-hardware.nixosModules.common-cpu-intel-cpu-only
	  "${nixos-hardware}/common/gpu/nvidia/pascal"
          nixos-hardware.nixosModules.common-pc
          nixos-hardware.nixosModules.common-pc-ssd

          {
            nixpkgs.overlays = [
              helium-flake.overlays.default
            ];
          }
        ];
      };

      homeConfigurations.matvii = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [ ./home-manager/home.nix ];
      };
    };
}
