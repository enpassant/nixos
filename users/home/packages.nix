{ pkgs, config, username, ... }:

let 
  inherit (import ../../options.nix) 
    browser flakeDir;
in {
  # Install Packages For The User
  home.packages = with pkgs; [
    pkgs."${browser}"
    wl-clipboard xclip
    gotop htop bottom
    mpc-cli pavucontrol
    aerc
    rofi-wayland bemoji
    mako
    mc lf
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
