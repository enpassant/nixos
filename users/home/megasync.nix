{ pkgs, config, lib, userSet, ... }:

let
  inherit (userSet) slickbar simplebar clock24h;
in {
  services.megasync = {
    enable = true;
    # forceWayland = true;
  };
}
