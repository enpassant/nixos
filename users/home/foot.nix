{ pkgs, config, lib, ... }:

let
  palette = config.colorScheme.palette;
  inherit (import ../../options.nix) foot;
in lib.mkIf (foot == true) {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";

        # font = "Fira Code:size=11";
        font = "JetBrainsMono Nerd Font:size=14";
      };

      mouse = {
        hide-when-typing = "yes";
      };
    };
  };
}
