{ pkgs, config, ... }:

{
  imports = [
    ./alacritty.nix
    ./foot.nix
    ./hyprland.nix
    ./kitty.nix
    ./lf.nix
    ./mako.nix
    ./mpd.nix
    ./ncmpcpp.nix
    ./packages.nix
    ./rofi.nix
    ./waybar.nix
    ./sway.nix

    # ./kdenlive.nix
    # ./neofetch.nix
    # ./starship.nix
    # ./swappy.nix
    # ./swaylock.nix
    # ./swaync.nix
    # ./bash.nix
    # ./gtk-qt.nix
    # ./wezterm.nix
    # ./zsh.nix

    ./files.nix
  ];
}
