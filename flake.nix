{
  description = "My first flake NixOS install";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {self, nixpkgs, home-manager, ...}:
  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      flake_mini_mbr = lib.nixosSystem {
        inherit system;
        modules = [ flake_mini_mbr/configuration.nix ];
      };
      flake_mini = lib.nixosSystem {
        inherit system;
        modules = [ flake_mini/configuration.nix ];
      };
      nixos = lib.nixosSystem {
        inherit system;
        modules = [ nixos/configuration.nix ];
      };
    };
    homeConfigurations = {
      feca = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./users/feca.nix ];
      };
    };
  };
}
