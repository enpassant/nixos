{ pkgs, config, lib, userSet, ... }:

let
  palette = config.colorScheme.palette;
  inherit (userSet) slickbar simplebar clock24h terminal;
  modulesSettings = {
      "hyprland/workspaces" = {
        #format = if simplebar == true then "{name}" else "{icon}";
      	format = "{icon}";
      	format-icons = {
          "1" = "1";
          "2" = "2";
          "3" = "3";
          "4" = "4";
          "5" = "5";
          "6" = "6";
          "7" = "7";
          "8" = "8";
          "9" = "9";
          "10" = "0";
      	};
      	on-scroll-up = "hyprctl dispatch workspace e+1";
      	on-scroll-down = "hyprctl dispatch workspace e-1";
      };

      "sway/workspaces" = {
        #format = if simplebar == true then "{name}" else "{icon}";
      	format = "{icon}";
      	format-icons = {
          "1" = "1";
          "2" = "2";
          "3" = "3";
          "4" = "4";
          "5" = "5";
          "6" = "6";
          "7" = "7";
          "8" = "8";
          "9" = "9";
          "10" = "0";
      	};
      	on-scroll-up = "swaymsg workspace next";
      	on-scroll-down = "swaymsg workspace prev";
      };
      "sway/mode" = {
      	"format" = " {}";
      	"max-length" = 50;
      };
      "hyprland/submap" = {
      	"format" = " {}";
      	"max-length" = 50;
      };
      "clock" = {
      	format = if clock24h == true then ''  {:%H:%M}''
      	else ''  {%I:%M %p}'';
            	tooltip = true;
        format-alt = ''📅 {:%Y, %B %d, %A (%R)}'';
      	tooltip-format = "<big>{:%A, %d.%B %Y }</big><tt><small>{calendar}</small></tt>";
      };
      "hyprland/window" = {
        format = "{}";
      	separate-outputs = true;
      };
      "sway/window" = {
      	max-length = 25;
      	separate-outputs = true;
      };
      "memory" = {
      	interval = 5;
      	format = " {}%";
        tooltip = true;
        on-click = "${terminal} -- btm";
      };
      "cpu" = {
      	interval = 5;
      	format = " {usage:2}%";
        tooltip = true;
        on-click = "${terminal} -- htop";
      };
      "disk" = {
        format = " {free}";
        tooltip = true;
        on-click = "${terminal} -- gotop";
      };
      "network" = {
        format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
        format-ethernet = " {bandwidthDownOctets}";
        format-wifi = "{icon} {signalStrength}%";
        format-disconnected = "󰤮";
        tooltip = false;
        on-click = "${terminal} -- nmtui";
      };
      "tray" = {
        spacing = 12;
      };
      "pulseaudio" = {
        format = "{icon} {volume}% {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        format-muted = " {format_source}";
        format-source = " {volume}%";
        format-source-muted = "";
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = ["" "" ""];
        };
        on-click = "pavucontrol";
      };
      "custom/themeselector" = {
        tooltip = false;
        format = "";
        # exec = "theme-selector";
        on-click = "sleep 0.1 && theme-selector";
      };
      "custom/startmenu" = {
        tooltip = false;
        format = " ";
        # exec = "rofi -show drun";
        on-click = "rofi -show drun";
      };
      "idle_inhibitor" = {
        format = "{icon}";
        format-icons = {
            activated = " ";
            deactivated = " ";
        };
        tooltip = "true";
      };
      "custom/notification" = {
        tooltip = false;
        format = "{icon} {}";
        format-icons = {
          notification = "<span foreground='red'><sup></sup></span>";
          none = "";
          dnd-notification = "<span foreground='red'><sup></sup></span>";
          dnd-none = "";
          inhibited-notification = "<span foreground='red'><sup></sup></span>";
          inhibited-none = "";
          dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
          dnd-inhibited-none = "";
       	};
        return-type = "json";
        exec-if = "which swaync-client";
        exec = "swaync-client -swb";
        on-click = "task-waybar";
        escape = true;
      };
      "battery" = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon} {capacity}%";
        format-charging = "󰂄 {capacity}%";
        format-plugged = "󱘖 {capacity}%";
        format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        on-click = "wlogout";
        tooltip = false;
      };
    };
in with lib; {
  # Configure & Theme Waybar
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = [
      (lib.attrsets.mergeAttrsList [ modulesSettings {
        layer = "top";
        position = "top";
        # output = "Virtual-1";

        modules-center = if simplebar == true then [ "sway/window" ]
        else [ "network" "pulseaudio" "cpu" "sway/workspaces" "memory" "disk" "clock" ];
        modules-left = if simplebar == true then ["custom/startmenu" "sway/workspaces" "cpu" "memory" "network"  ]
        else [ "custom/startmenu" "sway/window" ];
        modules-right = if simplebar == true then [ "idle_inhibitor" "custom/themeselector" "custom/notification" "pulseaudio" "clock"  "tray" ]
        else [ "sway/mode" "idle_inhibitor" "custom/themeselector" "custom/notification" "battery" "tray" ];
      } ])
      # (lib.attrsets.mergeAttrsList [ modulesSettings {
      #   layer = "top";
      #   position = "top";
      #   output = "!Virtual-1";

      #   modules-center = if simplebar == true then [ "hyprland/window" ]
      #   else [ "network" "pulseaudio" "cpu" "hyprland/workspaces" "memory" "disk" "clock" ];
      #   modules-left = if simplebar == true then ["custom/startmenu" "hyprland/workspaces" "cpu" "memory" "network"  ]
      #   else [ "custom/startmenu" "hyprland/window" ];
      #   modules-right = if simplebar == true then [ "idle_inhibitor" "custom/themeselector" "custom/notification" "pulseaudio" "clock"  "tray" ]
      #   else [ "hyprland/submap" "idle_inhibitor" "custom/themeselector" "custom/notification" "battery" "tray" ];
      # } ])
    ];
    style = concatStrings [''
      * {
	font-size: 16px;
	font-family: JetBrainsMono Nerd Font, Font Awesome, sans-serif;
    	font-weight: bold;
      }
      window#waybar {
	${if slickbar == true then ''
	  background-color: rgba(26,27,38,0);
	  border-bottom: 1px solid rgba(26,27,38,0);
	  border-radius: 0px;
	  color: #${palette.base0F};
	'' else if simplebar == true then ''
	  color: #${config.colorScheme.colors.base05};
	  background-color: #${palette.base00};
	  border-radius: 0px;
	  border-bottom: 1px solid rgba(26,27,38,0);
	'' else ''
	  background-color: #${palette.base00};
	  border-bottom: 1px solid #${palette.base00};
	  border-radius: 0px;
	  color: #${palette.base0F};
	''}
      }
      #workspaces {
	${if slickbar == true then ''
	  background: linear-gradient(180deg, #${palette.base00}, #${palette.base01});
	  margin: 5px;
	  padding: 0px 1px;
	  border-radius: 15px;
	  border: 0px;
	  font-style: normal;
	  color: #${palette.base00};
	'' else if simplebar == true then ''
	  color: #${config.colorScheme.colors.base05};
          background: transparent;
	  border-radius: 0px;
	  border: 0px;
	  font-style: normal;
	'' else ''
	  background: linear-gradient(45deg, #${palette.base01}, #${palette.base01});
	  margin: 4px;
	  padding: 0px 1px;
	  border-radius: 10px;
	  border: 0px;
	  font-style: normal;
	  color: #${palette.base00};
	''}
      }
      #workspaces button {
	${if slickbar == true then ''
	  padding: 0px 5px;
	  margin: 4px 3px;
	  border-radius: 15px;
	  border: 0px;
	  color: #${palette.base00};
	  background: linear-gradient(45deg, #${palette.base0D}, #${palette.base0E});
	  opacity: 0.5;
	  transition: all 0.3s ease-in-out;
	'' else if simplebar == true then ''
	  color: #${config.colorScheme.colors.base05};
          background: transparent;
	  opacity: 0.3;
	  border: 0px;
	  transition: all 0.3s ease-in-out;
	'' else ''
	  padding: 0px 5px;
	  margin: 4px 3px;
	  border-radius: 10px;
	  border: 0px;
	  color: #${palette.base00};
	  background: linear-gradient(45deg, #${palette.base06}, #${palette.base0E});
	  opacity: 0.5;
	  transition: all 0.3s ease-in-out;
	''}
      }
      #workspaces button.active {
	${if slickbar == true then ''
	  padding: 0px 5px;
	  margin: 4px 3px;
	  border-radius: 15px;
	  border: 0px;
	  color: #${palette.base00};
	  background: linear-gradient(45deg, #${palette.base0D}, #${palette.base0E});
	  opacity: 1.0;
	  min-width: 40px;
	  transition: all 0.3s ease-in-out;
	'' else if simplebar == true then ''
	  color: #${config.colorScheme.colors.base05};
          background: transparent;
	  opacity: 1.0;
	  border: 0px;
	  transition: all 0.3s ease-in-out;
	'' else ''
	  padding: 0px 5px;
	  margin: 4px 3px;
	  border-radius: 10px;
	  border: 0px;
	  color: #${palette.base00};
	  background: linear-gradient(45deg, #${palette.base06}, #${palette.base0E});
	  opacity: 1.0;
	  min-width: 40px;
	  transition: all 0.3s ease-in-out;
	''}
      }
      #workspaces button.focused {
	${if slickbar == true then ''
	  padding: 0px 5px;
	  margin: 4px 3px;
	  border-radius: 15px;
	  border: 0px;
	  color: #${palette.base00};
	  background: linear-gradient(45deg, #${palette.base0D}, #${palette.base0E});
	  opacity: 1.0;
	  min-width: 40px;
	  transition: all 0.3s ease-in-out;
	'' else if simplebar == true then ''
	  color: #${config.colorScheme.colors.base05};
          background: transparent;
	  opacity: 1.0;
	  border: 0px;
	  transition: all 0.3s ease-in-out;
	'' else ''
	  padding: 0px 5px;
	  margin: 4px 3px;
	  border-radius: 10px;
	  border: 0px;
	  color: #${palette.base00};
	  background: linear-gradient(45deg, #${palette.base06}, #${palette.base0E});
	  opacity: 1.0;
	  min-width: 40px;
	  transition: all 0.3s ease-in-out;
	''}
      }
      #workspaces button:hover {
	${if slickbar == true then ''
	  border-radius: 15px;
	  color: #${palette.base00};
	  background: linear-gradient(45deg, #${palette.base0D}, #${palette.base0E});
	  opacity: 0.8;
	'' else if simplebar == true then ''
	  color: #${config.colorScheme.colors.base05};
          background: transparent;
	  opacity: 0.8;
	  border: 0px;
	  transition: all 0.3s ease-in-out;
	'' else ''
	  border-radius: 10px;
	  color: #${palette.base00};
	  background: linear-gradient(45deg, #${palette.base06}, #${palette.base0E});
	  opacity: 0.8;
	''}
      }
      tooltip {
	background: #${palette.base00};
	border: 1px solid #${palette.base0E};
	border-radius: 10px;
      }
      tooltip label {
	color: #${palette.base07};
      }
      #window {
	${if slickbar == true then ''
	  color: #${palette.base05};
	  background: #${palette.base00};
	  border-radius: 50px 15px 50px 15px;
	  margin: 5px;
	  padding: 2px 20px;
	'' else if simplebar == true then ''
	  color: #${config.colorScheme.colors.base05};
          background: transparent;
	  margin: 4px;
	'' else ''
	  margin: 4px;
	  padding: 2px 10px;
	  color: #${palette.base05};
	  background: #${palette.base01};
	  border-radius: 10px;
	''}
      }
      #memory {
   	color: #${palette.base0F};
	${if slickbar == true then ''
	  background: #${palette.base00};
	  border-radius: 15px 50px 15px 50px;
	  margin: 5px;
	  padding: 2px 20px;
	'' else if simplebar == true then ''
	  color: #${config.colorScheme.colors.base05};
          background: transparent;
	  margin: 4px;
	'' else ''
	  background: #${palette.base01};
	  margin: 4px;
	  padding: 2px 10px;
	  border-radius: 10px;
	''}
      }
      #clock {
    	color: #${palette.base0B};
	${if slickbar == true then ''
	  background: #${palette.base00};
	  border-radius: 15px 50px 15px 50px;
	  margin: 5px;
	  padding: 2px 20px;
	'' else if simplebar == true then ''
	  color: #${config.colorScheme.colors.base05};
          background: transparent;
	  margin: 4px;
	'' else ''
	  background: #${palette.base01};
	  margin: 4px;
	  padding: 2px 10px;
	  border-radius: 10px;
	''}
      }
      #idle_inhibitor {
    	color: #${palette.base0A};
	${if slickbar == true then ''
	  background: #${palette.base00};
	  border-radius: 50px 15px 50px 15px;
	  margin: 5px;
	  padding: 2px 20px;
	'' else if simplebar == true then ''
	  color: #${config.colorScheme.colors.base05};
          background: transparent;
	  margin: 4px;
	'' else ''
	  background: #${palette.base01};
	  margin: 4px;
	  padding: 2px 10px;
	  border-radius: 10px;
	''}
      }
      #cpu {
    	color: #${palette.base07};
	${if slickbar == true then ''
	  background: #${palette.base00};
	  border-radius: 50px 15px 50px 15px;
	  margin: 5px;
	  padding: 2px 20px;
	'' else if simplebar == true then ''
	  color: #${config.colorScheme.colors.base05};
          background: transparent;
	  margin: 4px;
	'' else ''
	  background: #${palette.base01};
	  margin: 4px;
	  padding: 2px 10px;
	  border-radius: 10px;
	''}
      }
      #disk {
    	color: #${palette.base03};
	${if slickbar == true then ''
	  background: #${palette.base00};
	  border-radius: 15px 50px 15px 50px;
	  margin: 5px;
	  padding: 2px 20px;
	'' else if simplebar == true then ''
	  color: #${config.colorScheme.colors.base05};
          background: transparent;
	  margin: 4px;
	'' else ''
	  background: #${palette.base01};
	  margin: 4px;
	  padding: 2px 10px;
	  border-radius: 10px;
	''}
      }
      #battery {
    	color: #${palette.base08};
	${if slickbar == true then ''
	  background: #${palette.base00};
	  border-radius: 15px 50px 15px 50px;
	  margin: 5px;
	  padding: 2px 20px;
	'' else if simplebar == true then ''
	  color: #${config.colorScheme.colors.base05};
          background: transparent;
	  margin: 4px;
	'' else ''
	  background: #${palette.base01};
	  margin: 4px;
	  padding: 2px 10px;
	  border-radius: 10px;
	''}
      }
      #network {
    	color: #${palette.base09};
	${if slickbar == true then ''
	  background: #${palette.base00};
	  border-radius: 50px 15px 50px 15px;
	  margin: 5px;
	  padding: 2px 20px;
	'' else if simplebar == true then ''
	  color: #${config.colorScheme.colors.base05};
          background: transparent;
	  margin: 4px;
	'' else ''
	  background: #${palette.base01};
	  margin: 4px;
	  padding: 2px 10px;
	  border-radius: 10px;
	''}
      }
      #tray {
    	color: #${palette.base05};
	${if slickbar == true then ''
	  background: #${palette.base00};
	  border-radius: 15px 0px 0px 50px;
	  margin: 5px 0px 5px 5px;
	  padding: 2px 20px;
	'' else if simplebar == true then ''
	  color: #${config.colorScheme.colors.base05};
          background: transparent;
	  margin: 4px;
	'' else ''
	  background: #${palette.base01};
	  margin: 4px;
	  padding: 2px 10px;
	  border-radius: 10px;
	''}
      }
      #pulseaudio {
    	color: #${palette.base0D};
	${if slickbar == true then ''
	  background: #${palette.base00};
	  border-radius: 50px 15px 50px 15px;
	  margin: 5px;
	  padding: 2px 20px;
	'' else if simplebar == true then ''
	  color: #${config.colorScheme.colors.base05};
          background: transparent;
	  margin: 4px;
	'' else ''
	  background: #${palette.base01};
	  margin: 4px;
	  padding: 2px 10px;
	  border-radius: 10px;
	''}
      }
      #custom-notification {
    	color: #${palette.base0C};
	${if slickbar == true then ''
	  background: #${palette.base00};
	  border-radius: 15px 50px 15px 50px;
	  margin: 5px;
	  padding: 2px 20px;
	'' else if simplebar == true then ''
	  color: #${config.colorScheme.colors.base05};
          background: transparent;
	  margin: 4px;
	'' else ''
	  background: #${palette.base01};
	  margin: 4px;
	  padding: 2px 10px;
	  border-radius: 10px;
	''}
      }
      #custom-themeselector {
    	color: #${palette.base0D};
	${if slickbar == true then ''
	  background: #${palette.base00};
	  border-radius: 15px 50px 15px 50px;
	  margin: 5px;
	  padding: 2px 20px;
	'' else if simplebar == true then ''
	  color: #${config.colorScheme.colors.base05};
          background: transparent;
	  margin: 4px;
	'' else ''
	  background: #${palette.base01};
	  margin: 4px;
	  padding: 2px 10px;
	  border-radius: 10px;
	''}
      }
      #custom-startmenu {
    	color: #${palette.base03};
	${if slickbar == true then ''
	  background: #${palette.base00};
	  border-radius: 0px 15px 50px 0px;
	  margin: 5px 5px 5px 0px;
	  padding: 2px 20px;
	'' else if simplebar == true then ''
	  color: #${config.colorScheme.colors.base05};
          background: transparent;
	  margin: 4px;
	'' else ''
	  background: #${palette.base01};
	  margin: 4px;
	  padding: 2px 10px;
	  border-radius: 10px;
	''}
      }
      #idle_inhibitor {
    	color: #${palette.base09};
	${if slickbar == true then ''
	  background: #${palette.base00};
	  border-radius: 15px 50px 15px 50px;
	  margin: 5px;
	  padding: 2px 20px;
	'' else if simplebar == true then ''
	  color: #${config.colorScheme.colors.base05};
          background: transparent;
	  margin: 4px;
	'' else ''
	  background: #${palette.base01};
	  margin: 4px;
	  padding: 2px 10px;
	  border-radius: 10px;
	''}
      } ''
    ];
  };
}
