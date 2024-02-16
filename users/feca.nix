{ config, pkgs, ... }:
let
  inherit (import ../options.nix) 
    browser flakeDir;

  myAliases = {
    ho-rebuild="home-manager switch --flake ${flakeDir}";
    no-rebuild="sudo nixos-rebuild switch --flake ${flakeDir}";
    no-update="sudo nix flake update ${flakeDir}";
    gcCleanup="nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
    ll = "ls -alh";
    ".." = "cd ..";
  };
in {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "feca";
  home.homeDirectory = "/home/feca";

  imports = [
    # inputs.nix-colors.homeManagerModules.default
    # inputs.hyprland.homeManagerModules.default
    ./home
  ];

  wayland.windowManager.sway = {
    enable = true;
    xwayland = true;
    config = rec {
      modifier = "Mod4";
      # Use kitty as default terminal
      terminal = "foot";
      output = {
        "Virtual-1" = {
          mode = "1920x1080@60Hz";
        };
      };      
      startup = [
        # Launch Firefox on start
        {command = "foot";}
      ];
    };
  };

  programs.zsh = {
    enable = true;
    shellAliases = myAliases;
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
