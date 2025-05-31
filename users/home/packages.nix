{ pkgs, config, username, userSet, ... }:

let
  inherit (userSet) browser flakeDir;
in {
  # Install Packages For The User
  home.packages = with pkgs; [
    pkgs."${browser}"
    ghostty chafa
    swaybg shotman
    libsixel
    vim-full neovim nodejs-slim
    lazygit
    silver-searcher fzf atuin dust
    wl-clipboard xclip
    wlogout
    gotop htop bottom
    mpc-cli pavucontrol
    aerc pandoc
    marksman
    rofi-wayland
    libnotify
    mc
    exiftool
    jq file bat
    tldr fastfetch
    keepassxc
    megasync
    teams-for-linux
    remmina
    virtualbox qemu
    calibre
    font-awesome spotify swayidle swaylock
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    cmatrix
    brightnessctl
    vhs gum confetty slides graph-easy glow cowsay
    tmuxp
    zig zls gnumake
    gleam erlang rebar3 inotify-tools
    obs-studio vlc
  ];
}
