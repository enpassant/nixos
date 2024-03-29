{ pkgs, config, lib, userSet, ... }:

let
  palette = config.colorScheme.palette;
  inherit (userSet) alacritty;
in lib.mkIf (alacritty == true) {
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
	padding.x = 15;
	padding.y = 15;
	decorations = "none";
	startup_mode = "Windowed";
	dynamic_title = true;
	opacity = 0.0;
      };
      cursor = {
	style = {
	  shape = "Beam";
	  blinking = "On";
	};
      };
      live_config_reload = true;
      font = {
	normal.family = "JetBrainsMono Nerd Font";
	bold.family = "JetBrainsMono Nerd Font";
	italic.family = "JetBrainsMono Nerd Font";
	bold_italic.family = "JetBrainsMono Nerd Font";
	size = 14;
      };
    };
  };
}
