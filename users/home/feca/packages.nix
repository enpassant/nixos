{ pkgs, pkgs-unstable, config, username, userSet, ... }:

let
  inherit (userSet) browser flakeDir;
in {
  # Install Packages For The User
  home.packages = with pkgs; [
    pkgs."${browser}"
    gnupg pinentry-all
    ghostty chafa
    swaybg shotman
    libsixel
    vim-full neovim nodejs-slim
    lazygit
    silver-searcher fzf atuin dust
    wl-clipboard xclip
    wlogout
    gotop htop bottom
    mpc pavucontrol
    aerc pandoc
    marksman
    rofi
    libnotify
    mc
    exiftool
    jq file bat
    tldr fastfetch
    keepassxc
    teams-for-linux
    freerdp
    virtualbox qemu
    calibre
    font-awesome spotify swayidle swaylock
    nerd-fonts.jetbrains-mono
    cmatrix
    brightnessctl
    vhs gum confetty slides graph-easy glow cowsay
    tmuxp
    pkgs-unstable.zig_0_15 pkgs-unstable.zls_0_15 gnumake
    jetbrains.idea-ultimate
    gleam erlang rebar3 inotify-tools
    # roc
    koka
    obs-studio vlc
    yt-dlp
    xournalpp
    texliveFull
    duckdb
    xwayland-satellite
    xdg-desktop-portal-gnome
    blesh
    pkgs-unstable.iwe graphviz
  ];
}
