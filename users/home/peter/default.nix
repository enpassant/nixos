{ pkgs, config, ... }:

{
  imports = [
    # ./alacritty.nix
    # ./foot.nix
    # ./gc.nix
    # ./hyprland.nix
    # ./kitty.nix
    ./../lf.nix
    ./../mako.nix
    # ./megasync.nix
    ./../mpd.nix
    ./../niri.nix
    ./../ncmpcpp.nix
    ./packages.nix
    ./../rofi.nix
    ./../waybar.nix
    # ./sway.nix

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

    ./../files.nix
  ];
}
