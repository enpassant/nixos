{ pkgs, config, lib, userSet, ... }:

let
  inherit (userSet) slickbar simplebar clock24h;
in {
  services.home-manager.autoExpire = {
    enable = true;
    store.options = "--delete-older-than 30d";
  };
}
