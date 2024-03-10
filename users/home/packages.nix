{ pkgs, config, username, userSet, ... }:

let
  inherit (userSet) browser flakeDir;
in {
  # Install Packages For The User
  home.packages = with pkgs; [
    pkgs."${browser}"
    swaybg
    libsixel
    vim-full neovim nodejs-slim
    lazygit
    silver-searcher
    wl-clipboard xclip
    gotop htop bottom
    mpc-cli pavucontrol
    aerc pandoc
    rofi-wayland bemoji
    libnotify
    mc
    exiftool
    jq file bat
    keepassxc
    megasync
    teams-for-linux
    remmina
    virtualbox
    calibre
    font-awesome spotify swayidle swaylock
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    cmatrix
  ];
}
