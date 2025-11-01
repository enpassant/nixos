let
  toggleScript="bw_toggle_sink.sh";
in {
  # User Variables
  inherit toggleScript;
  flakeUser="-bw";
  theKBDLayout = "hu(us),hu(oldhunlig)";
  theKBDVariant = "";
  theKBDOptions = "grp:win_space_toggle,compose:sclk";
}
