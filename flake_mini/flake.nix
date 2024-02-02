{
  description = "My first flake NixOS install";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
  };

  outputs = {self, nixpkgs, ...}:
  let
    lib = nixpkgs.lib
  in {
    nixosConfigurations = {
      flake_minimal = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./configuration.nix ];
      }
    };
  };
}
