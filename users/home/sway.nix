{ pkgs, config, lib, inputs, userSet, ... }:

let
  theme = config.colorScheme.palette;
  hyprplugins = inputs.hyprland-plugins.packages.${pkgs.system};
  inherit (userSet)
    browser cpuType gpuType vm
    wallpaperDir borderAnim
    terminal
    toggleScript
    theKBDLayout theKBDVariant theKBDOptions
    sdl-videodriver;
in lib.mkIf (vm == "sway") {
  wayland.windowManager.sway = let
    modifier = "Mod4";
  in {
    enable = true;
    xwayland = true;
    checkConfig = false;
    config = rec {
      inherit modifier;
      terminal = "foot";
      menu = "rofi -show";
      input = {
        "*" = {
          xkb_layout = "${theKBDLayout}";
          xkb_variant = "${theKBDVariant}";
        	xkb_options = "${theKBDOptions}";
        };
      };
      output = {
        "Virtual-1" = {
          mode = "1920x1080@60Hz";
        };
        "eDP-1" = {
          pos = "0 0";
          mode = "1920x1080@60Hz";
        };
        "HDMI-A-1" = {
          pos = "1920 0";
          mode = "1920x1080@60Hz";
        };
      };
      startup = [
        {
          command ="swayidle -w timeout 5 'if pgrep -c swaylock; then swaymsg \"output * power off\"; fi' resume 'swaymsg \"output * power on\"'";
          always = true;
        }
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
          m = ''mode music; exec sh ~/bin/show-app-noti.sh "Sway-mode" "Music modee" "n - Start music player\nh - Previous track\nl - Next track\nk - Volume up\nj - Volume down\nm - Mute toggle\nf - Seek forward\nb - Seek backward\np - Pause/Play\ns - Stop\nz - Toggle Speaker/Headphone\nESC - exit to normal mode\nENTER - exit to normal mode"'';
        };
        music = {
          Escape = "mode default; exec sh ~/bin/hide-app-noti.sh Sway-mode";
          Return = "mode default; exec sh ~/bin/hide-app-noti.sh Sway-mode";
          n = "exec ${terminal} -- ncmpcpp";
          h = "exec mpc prev";
          l = "exec mpc next";
          k = "exec pactl set-sink-volume `pactl get-default-sink` +5%";
          j = "exec pactl set-sink-volume `pactl get-default-sink` -5%";
          m = "exec pactl set-sink-mute `pactl get-default-sink` toggle";
          f = "exec mpc seek +10";
          b = "exec mpc seek -10";
          p = "exec mpc toggle";
          s = "exec mpc stop";
          z = "exec ~/bin/${toggleScript}";
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
        # commands = [
        #   {
        #     command = "opacity set 0.95";
        #     criteria = { title = ".*"; };
        #   }
        # ];
      };
    };
    extraConfig = ''
      bindsym ${modifier}+Control+l exec swaylock
      unbindsym ${modifier}+Shift+e
      bindsym ${modifier}+Shift+e exec wlogout
      bindsym ${modifier}+m mode modes; exec sh ~/bin/show-app-noti.sh "Sway-mode" "Modes mode" "r - resize\nm - music\nESC - exit to normal mode\nENTER - exit to normal mode"
      unbindsym ${modifier}+r
      unbindsym ${modifier}+Shift+q
      bindsym ${modifier}+period input type:keyboard xkb_switch_layout next
      bindsym ${modifier}+q kill
      bindsym ${modifier}+z exec ~/bin/${toggleScript}
      bindsym ${modifier}+t exec ~/bin/toggle_input_sinks.sh
      bindsym ${modifier}+Shift+w opacity plus 0.05
      bindsym ${modifier}+Shift+s opacity minus 0.05
      bindsym Print               exec shotman -c output -C
      bindsym Print+Shift         exec shotman -c region -C
      bindsym Print+Shift+Control exec shotman -c window -C

      bindsym XF86AudioRaiseVolume exec pactl set-sink-volume `pactl get-default-sink` +5%
      bindsym XF86AudioLowerVolume exec pactl set-sink-volume `pactl get-default-sink` -5%
      bindsym XF86AudioMute exec  pactl set-sink-mute `pactl get-default-sink` toggle
      bindsym XF86AudioPlay exec  mpc toggle
      bindsym XF86AudioPause exec  mpc toggle
      bindsym XF86AudioNext exec  mpc next
      bindsym XF86AudioPrev exec  mpc prev
      bindsym XF86AudioStop exec  mpc stop
      bindsym XF86MonBrightnessDown exec brightnessctl set 5%-
      bindsym XF86MonBrightnessUp exec brightnessctl set +5%
      bindsym XF86Tools exec  ${terminal} -- ncmpcpp
      bindsym XF86Calculator exec  gnome-calculator
      bindsym XF86Search exec  ${terminal} -- lf ~
      bindsym XF86Explorer exec  ${browser}

      default_border pixel 1
      smart_gaps on
      output * background ~/wallpapers/aniket-deole-M6XC789HLe8-unsplash.jpg fill

      WORKSPACE 1
      WORKSPACE 3
      WORKSPACE 10
      WORKSPACE 1
      WORKSPACE 3
      WORKSPACE 2
      WORKSPACE 1
    '';
  };
}
