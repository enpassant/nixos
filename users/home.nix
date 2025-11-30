{ config, pkgs, pkgs-unstable, inputs, lib, userSet, ... }:
let
  inherit (userSet)
    username userHome editor
    browser flakeDir flakeUser theme
    theKBDLayout theKBDVariant theKBDOptions;

  myAliases = {
    ho-rebuild="home-manager switch --flake ${flakeDir}#${username}${flakeUser}";
    no-rebuild="sudo nixos-rebuild switch --flake ${flakeDir}";
    no-update="sudo nix flake update --flake ${flakeDir}";
    gcCleanup="nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
    ll = "ls -alh";
    ".." = "cd ..";
    megasync="QT_QPA_PLATFORM=xcb megasync";
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
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
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

  services.wayvnc = {
    enable = true;
    settings = {
      address = "localhost";
      port = 15901;
    };
  };
  
  gtk.colorScheme = "dark";

  colorScheme = inputs.nix-colors.colorSchemes."${theme}";

  imports = [
    inputs.nix-colors.homeManagerModules.default
    # inputs.hyprland.homeManagerModules.default
    ./home/${username}
  ];

  programs.bash = {
    enable = true;
    shellAliases = myAliases;
    bashrcExtra = ''
      [[ $- == *i* ]] && source -- "$(blesh-share)"/ble.sh --attach=none
      source $HOME/.config/user-dirs.dirs
      eval "$(atuin init bash)"
      [[ ! ''${BLE_VERSION-} ]] || ble-attach
    '';
  };

  # programs.blesh.enable = true;

  programs.zsh = {
    enable = true;
    shellAliases = myAliases;
    initContent = ''
      source $HOME/.config/user-dirs.dirs
      bindkey ^R history-incremental-pattern-search-backward
      eval "$(atuin init zsh)"
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
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
