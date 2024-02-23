{ pkgs, config, ... }:

{
  imports = [
    ./alacritty.nix
    ./foot.nix
    # ./bash.nix
    # ./gtk-qt.nix
     ./hyprland.nix
     ./kitty.nix
    # ./kdenlive.nix
    # ./neofetch.nix
    ./lf.nix
    ./mako.nix
    ./mpd.nix
    ./ncmpcpp.nix
    ./packages.nix
    ./rofi.nix
    # ./starship.nix
    ./waybar.nix
    # ./swappy.nix
    # ./swaylock.nix
    # ./swaync.nix
    ./sway.nix
    # ./wezterm.nix
    # ./zsh.nix

    ./files.nix
  ];
}
