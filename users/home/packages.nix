{ pkgs, config, username, ... }:

let 
  inherit (import ../../options.nix) 
    browser flakeDir;
in {
  # Install Packages For The User
  home.packages = with pkgs; [
    pkgs."${browser}"
    gotop htop bottom
    mpd ncmpcpp
    aerc
    waybar
    rofi-wayland
    mako
    lf
    keepassxc
    megasync
    teams-for-linux
    remmina
    virtualbox
    clementine
    font-awesome spotify swayidle neovide element-desktop swaylock
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
}
