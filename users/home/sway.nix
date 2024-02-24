{ pkgs, config, lib, inputs, userSet, ... }:

let
  theme = config.colorScheme.palette;
  hyprplugins = inputs.hyprland-plugins.packages.${pkgs.system};
  inherit (userSet)
    browser cpuType gpuType vm
    wallpaperDir borderAnim
    terminal
    theKBDLayout theKBDVariant theKBDOptions
    sdl-videodriver;
in lib.mkIf (vm == "sway") {
  wayland.windowManager.sway = let
    modifier = "Mod4";
  in {
    enable = true;
    xwayland = true;
    config = rec {
      inherit modifier;
      terminal = "foot";
      menu = "rofi -show";
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
      gaps = {
        inner = 12;
        outer = 10;
      };
      modes = {
        modes = {
          Escape = "mode default; exec sh ~/bin/hide-app-noti.sh Sway-mode";
          Return = "mode default; exec sh ~/bin/hide-app-noti.sh Sway-mode";
          r = ''mode resize; exec sh ~/bin/show-app-noti.sh "Sway-mode" "Resize mode" "j,Down - Resize grow height 10px\nk,Up - Resize shrink height 10 px\nh,Left - Resize shrink width 10 px\nl,Right - Resize grow width 10 px\na - Move left with 10px\nd - Move right with 10px\nw - Move up with 10px\ns - Move down with 10px\nESC - exit to normal mode\nENTER - exit to normal mode"'';
          m = ''mode music; exec sh ~/bin/show-app-noti.sh "Sway-mode" "Music modee" "n - Start music player\nh - Previous track\nl - Next track\nk - Volume up\nj - Volume down\nm - Mute toggle\nf - Seek forward\nb - Seek backward\np - Pause/Play\ns - Stop\nESC - exit to normal mode\nENTER - exit to normal mode"'';
        };
        music = {
          Escape = "mode default; exec sh ~/bin/hide-app-noti.sh Sway-mode";
          Return = "mode default; exec sh ~/bin/hide-app-noti.sh Sway-mode";
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
          Escape = "mode default; exec sh ~/bin/hide-app-noti.sh Sway-mode";
          Return = "mode default; exec sh ~/bin/hide-app-noti.sh Sway-mode";
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
      window = {
        titlebar = false;
        commands = [
          {
            command = "opacity set 0.95";
            criteria = { title = ".*"; };
          }
        ];
      };
    };
    extraConfig = ''
      bindsym Mod4+m mode modes; exec sh ~/bin/show-app-noti.sh "Sway-mode" "Modes mode" "r - resize\nm - music\nESC - exit to normal mode\nENTER - exit to normal mode"
      unbindsym Mod4+r
      unbindsym Mod4+Shift+q
      bindsym ${modifier}+q kill
      bindsym Mod4+Shift+w opacity plus 0.05
      bindsym Mod4+Shift+s opacity minus 0.05
      bindsym Print               exec shotman -c output
      bindsym Print+Shift         exec shotman -c region
      bindsym Print+Shift+Control exec shotman -c window

      default_border none
      smart_gaps on
      output * background ~/wallpapers/aniket-deole-M6XC789HLe8-unsplash.jpg fill
    '';
  };
}
