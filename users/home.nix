{ config, pkgs, inputs, lib, userSet, ... }:
let
  inherit (userSet)
    username userHome editor
    browser flakeDir theme
    theKBDLayout theKBDVariant theKBDOptions;

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
  home = {
    username = "${username}";
    homeDirectory = "${userHome}";
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = 1;
      EDITOR = "${editor}";
    };
    keyboard = {
      layout = "${theKBDLayout}";
      variant = "${theKBDVariant}";
      options = "${theKBDOptions}";
    };
  };

  dconf.settings = {
    "org.gnome.desktop.input-sources" = {
      sources = "[ ('xkb', 'us'),  ('xkb' '${theKBDLayout}+${theKBDVariant}') ]";
      xkb-options = [ "${theKBDOptions}" ];
    };
  };

  colorScheme = inputs.nix-colors.colorSchemes."${theme}";

  imports = [
    inputs.nix-colors.homeManagerModules.default
    # inputs.hyprland.homeManagerModules.default
    ./home
  ];

  programs.bash = {
    enable = true;
    shellAliases = myAliases;
    bashrcExtra = ''
      source $HOME/.config/user-dirs.dirs
    '';
  };

  programs.zsh = {
    enable = true;
    shellAliases = myAliases;
    initExtra = ''
      source $HOME/.config/user-dirs.dirs
      bindkey ^R history-incremental-pattern-search-backward
    '';
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
