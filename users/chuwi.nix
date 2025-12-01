let
  toggleScript="chuwi_toggle_sink_hdmi.sh";
in {
  # User Variables
  inherit toggleScript;
  flakeUser="-chuwi";
  theKBDLayout = "hu(us),hu(oldhunlig)";
  theKBDVariant = "";
  theKBDOptions = "grp:win_space_toggle,compose:sclk";
  monitor1Name = "DP-1";
  monitor1Mode = "3840x2160";
  monitor1PositionX = "0";
  monitor1Scale = "2";
  monitor2Name = "HDMI-A-1";
}
