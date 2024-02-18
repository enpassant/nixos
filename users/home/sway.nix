{ pkgs, config, lib, inputs, userSet, ... }:

let
  theme = config.colorScheme.palette;
  hyprplugins = inputs.hyprland-plugins.packages.${pkgs.system};
  inherit (userSet)
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
      modes = {
        modes = {
          Escape = "mode default";
          Return = "mode default";
          r = ''mode resize; exec makoctl dismiss -a; exec notify-send -a "Sway-mode" "Resize mode" "j,Down  - Resize grow height 10px\nk,Up    - Resize shrink height by 10 px\nh,Left  - Resize shrink width by 10 px\nl,Right - Resize grow width by 10 px\na       - Move left with 10px\nd       - Move right with 10px\nw       - Move up with 10px\ns       - Move down with 10px\nESC     - exit to normal mode\nENTER   - exit to normal mode"'';
          m = ''mode music; exec makoctl dismiss -a; exec notify-send -a "Sway-mode" "Music modee" "n     - Start music player\nh     - Previous track\nl     - Next track\nk     - Volume up\nj     - Volume down\nm     - Mute toggle\nf     - Seek forward\nb     - Seek backward\np     - Pause/Play\ns     - Stop\nESC   - exit to normal mode\nENTER - exit to normal mode"'';
        };
        music = {
          Escape = "mode default";
          Return = "mode default";
          n = "exec ${terminal} -- ncmpcpp";
          h = "exec mpc prev";
          l = "exec mpc next";
          k = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
          j = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          m = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          f = "exec mpc seek +10";
          b = "exec mpc seek -10";
          p = "exec mpc toggle";
          s = "exec mpc stop";
        };
        resize = {
          Escape = "mode default";
          Return = "mode default";
          Down = "resize grow height 10 px";
          Left = "resize shrink width 10 px";
          Right = "resize grow width 10 px";
          Up = "resize shrink height 10 px";
          h = "resize shrink width 10 px";
          j = "resize grow height 10 px";
          k = "resize shrink height 10 px";
          l = "resize grow width 10 px";
          a = "move left 10 px";
          d = "move right 10 px";
          w = "move up 10 px";
          s = "move down 10 px";
        };
      };
    };
    extraConfig = ''
      bindsym Mod4+m mode modes; exec notify-send -a "Sway-mode" "Modes mode" "r     - resize\nm     - music\nESC   - exit to normal mode\nENTER - exit to normal mode"
      bindsym Print               exec shotman -c output
      bindsym Print+Shift         exec shotman -c region
      bindsym Print+Shift+Control exec shotman -c window
    '';
  };
}
