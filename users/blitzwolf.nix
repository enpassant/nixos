let
  toggleScript="bw_toggle_sink_hdmi.sh";
in {
  # User Variables
  inherit toggleScript;
  flakeUser="-bw";
  theKBDLayout = "hu,hu(us),hu(oldhunlig)";
  theKBDVariant = "";
  theKBDOptions = "grp:win_space_toggle,compose:sclk";
  monitor1Name = "HDMI-A-1";
  monitor1Mode = "3840x2160";
  monitor1PositionX = "0";
  monitor1Scale = "2";
}
