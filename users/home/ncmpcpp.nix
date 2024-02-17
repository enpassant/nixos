{ pkgs, config, lib, ... }:

let
  palette = config.colorScheme.palette;
  inherit (import ../../options.nix) slickbar simplebar clock24h;
in with lib; {
  programs.ncmpcpp = {
    enable = true;
    package = pkgs.ncmpcpp.override { visualizerSupport = true; };
    settings = {
      visualizer_output_name = "fifo";
      visualizer_in_stereo = "yes";
    };
  };
}
