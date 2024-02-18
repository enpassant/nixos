{ pkgs, config, lib, userSet, ... }:

let
  inherit (userSet) slickbar simplebar clock24h;
in {
  services.mako = {
    enable = true;
    defaultTimeout = 10000;
    icons = true;
  };
}
