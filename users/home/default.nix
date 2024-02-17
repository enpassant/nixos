{ pkgs, config, ... }:

{
  imports = [
    ./alacritty.nix
    ./foot.nix
    # ./bash.nix
    # ./gtk-qt.nix
    # ./hyprland.nix
    # ./kdenlive.nix
    # ./kitty.nix
    # ./neofetch.nix
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

    # ./files.nix
  ];
}
