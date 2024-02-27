{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/nur"; # In inputs

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nur, nixpkgs, ... }@inputs: 
  let system = "x86_64-linux";
      stateVersion = "23.11"; # Please read the comment before changing.
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          inputs.nur.overlay
        ];
        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
        };
      };
  in

  { nixosConfigurations.default = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs self stateVersion pkgs; };
      modules = [
        ./hosts/default/configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };

  };
}

