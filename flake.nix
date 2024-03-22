{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/nur"; # In inputs

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tomato-c = {
      url = "github:gabrielzschmitz/Tomato.C";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nur, nixpkgs, tomato-c, ... }@inputs:
    let
      changeGcc = final: prev: { gcc = pkgs.gcc12; };
      system = "x86_64-linux";
      stateVersion = "23.11"; # Please read the comment before changing.
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ inputs.nur.overlay ];
        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
          cudaSupport = true;
          nvidia.acceptLicense = true;
        };
      };

    in {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs self stateVersion pkgs;
          tomato-c = tomato-c.defaultPackage.${system};
        };
        modules = [
          ./hosts/default/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };

    };
}

