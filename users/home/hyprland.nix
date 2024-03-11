{ pkgs, config, lib, inputs, userSet, ... }:

let
  hyprplugins = inputs.hyprland-plugins.packages.${pkgs.system};
  inherit (userSet)
    browser cpuType gpuType vm theme
    wallpaperDir borderAnim
    defaultSink
    theKBDLayout terminal
    theKBDVariant
    theKBDOptions sdl-videodriver;
  colorScheme = inputs.nix-colors.colorSchemes."${theme}";
  palette = colorScheme.palette;
in lib.mkIf (vm == "hyprland" || vm == "sway") {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    plugins = [
      # hyprplugins.hyprtrails
    ];
    extraConfig = let
      modifier = "SUPER";
    in lib.concatStrings [ ''
      monitor=,preferred,auto,1
      windowrule = float, ^(steam)$
      windowrule = size 1080 900, ^(steam)$
      windowrule = center, ^(steam)$
      windowrulev2 = noblur,class:^(Alacritty)$
      windowrulev2 = noshadow,class:^(Alacritty)$
      windowrulev2 = noborder,class:^(Alacritty)$
      general {
        gaps_in = 6
        gaps_out = 8
        border_size = 2
        col.active_border = rgba(${palette.base0C}ff) rgba(${palette.base0D}ff) rgba(${palette.base0B}ff) rgba(${palette.base0E}ff) 45deg
        col.inactive_border = rgba(${palette.base00}cc) rgba(${palette.base01}cc) 45deg
        layout = dwindle
        resize_on_border = true
      }

      input {
        kb_layout = ${theKBDLayout}
        kb_variant = ${theKBDVariant}
	kb_options = ${theKBDOptions}
        follow_mouse = 1
        touchpad {
          natural_scroll = false
        }
        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
        accel_profile = flat
      }
      env = NIXOS_OZONE_WL, 1
      env = NIXPKGS_ALLOW_UNFREE, 1
      env = XDG_CURRENT_DESKTOP, Hyprland
      env = XDG_SESSION_TYPE, wayland
      env = XDG_SESSION_DESKTOP, Hyprland
      env = GDK_BACKEND, wayland
      env = CLUTTER_BACKEND, wayland
      env = SDL_VIDEODRIVER, ${sdl-videodriver}
      env = QT_QPA_PLATFORM, wayland
      env = QT_WAYLAND_DISABLE_WINDOWDECORATION, 1
      env = QT_AUTO_SCREEN_SCALE_FACTOR, 1
      env = MOZ_ENABLE_WAYLAND, 1
      ${if cpuType == "vm" then ''
        env = WLR_NO_HARDWARE_CURSORS,1
        env = WLR_RENDERER_ALLOW_SOFTWARE,1
      '' else ''
      ''}
      ${if gpuType == "nvidia" then ''
        env = WLR_NO_HARDWARE_CURSORS,1
      '' else ''
      ''}
      gestures {
        workspace_swipe = true
        workspace_swipe_fingers = 3
      }
      misc {
        mouse_move_enables_dpms = true
        key_press_enables_dpms = false
      }
      animations {
        enabled = yes
        bezier = wind, 0.05, 0.9, 0.1, 1.05
        bezier = winIn, 0.1, 1.1, 0.1, 1.1
        bezier = winOut, 0.3, -0.3, 0, 1
        bezier = liner, 1, 1, 1, 1
        animation = windows, 1, 6, wind, slide
        animation = windowsIn, 1, 6, winIn, slide
        animation = windowsOut, 1, 5, winOut, slide
        animation = windowsMove, 1, 5, wind, slide
        animation = border, 1, 1, liner
        ${if borderAnim == true then ''
          animation = borderangle, 1, 30, liner, loop
        '' else ''
        ''}
        animation = fade, 1, 10, default
        animation = workspaces, 1, 5, wind
      }
      decoration {
        rounding = 10
        drop_shadow = true
        active_opacity = 0.95
        inactive_opacity = 0.7
        blur {
            enabled = true
            size = 8
            passes = 1
            new_optimizations = on
            ignore_opacity = off
        }
      }
      plugin {
        hyprtrails {
          color = rgba(${palette.base0A}ff)
        }
      }
      exec-once = $POLKIT_BIN
      exec-once = dbus-update-activation-environment --systemd --all
      exec-once = systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec-once = swww init
      exec-once = waybar
      exec-once = swaync
      exec-once = wallsetter
      exec-once = nm-applet --indicator
      exec-once = swayidle -w timeout 720 'swaylock -f' timeout 800 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' before-sleep 'swaylock -f -c 000000'
      dwindle {
        pseudotile = true
        preserve_split = true
      }
      master {
        new_is_master = true
      }
      bind = ${modifier},Return,exec,${terminal}
      bind = ${modifier},D,exec,rofi -show
      bind = ${modifier}SHIFT,S,exec,swaync-client -rs
      ${if browser == "google-chrome" then ''
	bind = ${modifier},W,exec,google-chrome-stable
      '' else ''
	bind = ${modifier},W,exec,${browser}
      ''}
      bind = ${modifier},S,exec,screenshootin
      bind = ${modifier},Q,killactive,
      bind = ${modifier},P,pseudo,
      bind = ${modifier}SHIFT,I,togglesplit,
      bind = ${modifier},F,fullscreen,
      bind = ${modifier},Z,exec, ~/bin/toggle_sink_port.sh
      bind = ${modifier}SHIFT,F,togglefloating,
      bind = ${modifier}SHIFT,C,exit,
      bind = ${modifier}SHIFT,left,movewindow,l
      bind = ${modifier}SHIFT,right,movewindow,r
      bind = ${modifier}SHIFT,up,movewindow,u
      bind = ${modifier}SHIFT,down,movewindow,d
      bind = ${modifier}SHIFT,h,movewindow,l
      bind = ${modifier}SHIFT,l,movewindow,r
      bind = ${modifier}SHIFT,k,movewindow,u
      bind = ${modifier}SHIFT,j,movewindow,d
      bind = ${modifier},left,movefocus,l
      bind = ${modifier},right,movefocus,r
      bind = ${modifier},up,movefocus,u
      bind = ${modifier},down,movefocus,d
      bind = ${modifier},h,movefocus,l
      bind = ${modifier},l,movefocus,r
      bind = ${modifier},k,movefocus,u
      bind = ${modifier},j,movefocus,d
      bind = ${modifier},1,workspace,1
      bind = ${modifier},2,workspace,2
      bind = ${modifier},3,workspace,3
      bind = ${modifier},4,workspace,4
      bind = ${modifier},5,workspace,5
      bind = ${modifier},6,workspace,6
      bind = ${modifier},7,workspace,7
      bind = ${modifier},8,workspace,8
      bind = ${modifier},9,workspace,9
      bind = ${modifier},0,workspace,10
      bind = ${modifier}SHIFT,1,movetoworkspace,1
      bind = ${modifier}SHIFT,2,movetoworkspace,2
      bind = ${modifier}SHIFT,3,movetoworkspace,3
      bind = ${modifier}SHIFT,4,movetoworkspace,4
      bind = ${modifier}SHIFT,5,movetoworkspace,5
      bind = ${modifier}SHIFT,6,movetoworkspace,6
      bind = ${modifier}SHIFT,7,movetoworkspace,7
      bind = ${modifier}SHIFT,8,movetoworkspace,8
      bind = ${modifier}SHIFT,9,movetoworkspace,9
      bind = ${modifier}SHIFT,0,movetoworkspace,10
      bind = ${modifier}CONTROL,right,workspace,e+1
      bind = ${modifier}CONTROL,left,workspace,e-1
      bind = ${modifier},mouse_down,workspace, e+1
      bind = ${modifier},mouse_up,workspace, e-1
      bindm = ${modifier},mouse:272,movewindow
      bindm = ${modifier},mouse:273,resizewindow
      bind = ALT,Tab,cyclenext
      bind = ALT,Tab,bringactivetotop
      bind = ,XF86AudioRaiseVolume,exec,pactl set-sink-volume ${defaultSink} +5%
      bind = ,XF86AudioLowerVolume,exec,pactl set-sink-volume ${defaultSink} -5%
      bind = ,XF86AudioMute, exec, pactl set-sink-mute ${defaultSink} toggle
      bind = ,XF86AudioPlay, exec, mpc toggle
      bind = ,XF86AudioPause, exec, mpc toggle
      bind = ,XF86AudioNext, exec, mpc next
      bind = ,XF86AudioPrev, exec, mpc prev
      bind = ,XF86AudioStop, exec, mpc stop
      bind = ,XF86MonBrightnessDown,exec,brightnessctl set 5%-
      bind = ,XF86MonBrightnessUp,exec,brightnessctl set +5%
      bind = ,XF86Tools, exec, ${terminal} -- ncmpcpp
      bind = ,XF86Calculator, exec, gnome-calculator
      bind = ,XF86Search, exec, ${terminal} -- lf ~
      bind = ,XF86Explorer, exec, ${browser}

      bind = ${modifier},z,exec,~/bin/toggle_sink_port.sh

      bind = ${modifier},M,exec, ~/bin/show-app-noti.sh "Sway-mode" "Modes mode" "r - resize\nm - music\nESC - exit to normal mode\nENTER - exit to normal mode"
      bind = ${modifier},M,submap,modes

      submap=modes
      bind = ,R,exec, ~/bin/show-app-noti.sh "Sway-mode" "Resize mode" "j,Down - Resize grow height 10px\nk,Up - Resize shrink height 10 px\nh,Left - Resize shrink width 10 px\nl,Right - Resize grow width 10 px\na - Move left with 10px\nd - Move right with 10px\nw - Move up with 10px\ns - Move down with 10px\nESC - exit to normal mode\nENTER - exit to normal mode"
      bind = ,R,submap,resize
      bind = ,M,exec, ~/bin/show-app-noti.sh "Sway-mode" "Music modee" "n - Start music player\nh - Previous track\nl - Next track\nk - Volume up\nj - Volume down\nm - Mute toggle\nf - Seek forward\nb - Seek backward\np - Pause/Play\ns - Stop\nz - Toggle Speaker/Headphone\nESC - exit to normal mode\nENTER - exit to normal mode"
      bind = ,M,submap,music
      bind = ,Escape,exec, ~/bin/hide-app-noti.sh Sway-mode
      bind = ,Escape,submap,reset
      bind = ,Return,exec, ~/bin/hide-app-noti.sh Sway-mode
      bind = ,Return,submap,reset
      submap=reset

      submap=music
      bind = ,N,exec,${terminal} -- ncmpcpp
      bind = ,H,exec, mpc prev
      bind = ,L,exec, mpc next
      bind = ,K,exec, pactl set-sink-volume ${defaultSink} +5%
      bind = ,J,exec, pactl set-sink-volume ${defaultSink} -5%
      bind = ,M,exec, pactl set-sink-mute ${defaultSink} toggle
      bind = ,F,exec, mpc seek +10
      bind = ,B,exec, mpc seek -10
      bind = ,P,exec, mpc toggle
      bind = ,S,exec, mpc stop
      bind = ,Z,exec, ~/bin/toggle_sink_port.sh
      bind = ,Escape,exec, ~/bin/hide-app-noti.sh Sway-mode
      bind = ,Escape,submap,reset
      bind = ,Return,exec, ~/bin/hide-app-noti.sh Sway-mode
      bind = ,Return,submap,reset
      submap=reset

      submap=resize
      binde = ,right,resizeactive,10 0
      binde = ,left,resizeactive,-10 0
      binde = ,up,resizeactive,0 -10
      binde = ,down,resizeactive,0 10
      binde = ,l,resizeactive,10 0
      binde = ,h,resizeactive,-10 0
      binde = ,k,resizeactive,0 -10
      binde = ,j,resizeactive,0 10
      bind = ,Escape,exec, ~/bin/hide-app-noti.sh Sway-mode
      bind = ,Escape,submap,reset
      bind = ,Return,exec, ~/bin/hide-app-noti.sh Sway-mode
      bind = ,Return,submap,reset
      submap=reset

    '' ];
  };
}
