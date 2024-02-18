{ pkgs, config, lib, userSet, ... }:

let
  inherit (userSet) slickbar simplebar clock24h;
in {
  services.mako = {
    enable = true;
    defaultTimeout = 10000;
    icons = true;
    height = 400;
    extraConfig = ''
      [urgency=low]
      background-color=#268026FF

      [urgency=normal]
      background-color=#262680FF

      [urgency=critical]
      background-color=#802626FF

      [app-name="Sway-mode"]
      background-color=#8a8a15FF
      anchor=bottom-right
    '';
  };
}
