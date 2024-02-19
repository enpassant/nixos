{ pkgs, config, username, userSet, ... }:

let
  inherit (userSet) browser flakeDir;
in {
  # Install Packages For The User
  home.packages = with pkgs; [
    pkgs."${browser}"
    vim-full neovim nodejs-slim
    silver-searcher
    wl-clipboard xclip
    gotop htop bottom
    mpc-cli pavucontrol
    aerc
    rofi-wayland bemoji
    libnotify
    mc lf
    jq
    keepassxc
    megasync
    teams-for-linux
    remmina
    virtualbox
    clementine
    font-awesome spotify swayidle swaylock
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
}
