{ pkgs, config, lib, inputs, ... }:

let
  theme = config.colorScheme.palette;
  hyprplugins = inputs.hyprland-plugins.packages.${pkgs.system};
  inherit (import ../../options.nix) 
    browser cpuType gpuType vm
    wallpaperDir borderAnim
    theKBDLayout terminal
    theSecondKBDLayout
    theKBDVariant sdl-videodriver;
in lib.mkIf (vm == "sway") {
  wayland.windowManager.sway = {
    enable = true;
    xwayland = true;
    config = rec {
      modifier = "Mod4";
      # Use kitty as default terminal
      terminal = "foot";
      menu = "rofi -show combi -modes \"combi,window,drun,run\" -combi-modes=\"combi,window,drun,run\"";
      output = {
        "Virtual-1" = {
          mode = "1920x1080@60Hz";
        };
      };      
      startup = [
        { command = "foot"; }
      ];
      bars = [
        {
          command = "waybar";
        }
      ];
    };
  };
}
