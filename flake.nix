{
  description = "My first flake NixOS install";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
  };

  outputs = {self, nixpkgs, ...}:
  let
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      flake_mini_mbr = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ flake_mini_mbr/configuration.nix ];
      };
      flake_mini = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ flake_mini/configuration.nix ];
      };
      nixos = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ nixos/configuration.nix ];
      };
    };
  };
}
