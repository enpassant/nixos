{
  description = "My first flake NixOS install";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.url = "github:misterio77/nix-colors";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = inputs@{self, nixpkgs, home-manager, ...}:
  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
	    allowUnfree = true;
      };
    };
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
      nixos-sdc6 = lib.nixosSystem {
        specialArgs = {
          inherit system;
          inherit inputs;
          sysSet = (import ./system/nixos-sdc6.nix) //
            (import ./system/nixos.nix);
        };
        modules = [ nixos/configuration.nix ];
      };
      nixos-vm = lib.nixosSystem {
        specialArgs = {
          inherit system;
          inherit inputs;
          sysSet = (import ./system/nixos-vm.nix) //
            (import ./system/nixos.nix);
        };
        modules = [ nixos/configuration.nix ];
      };
    };
    homeConfigurations = {
      feca = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs;
          userSet = import ./users/feca.nix;
        };
        modules = [ ./users/home.nix ];
      };
    };
  };
}
