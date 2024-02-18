{ pkgs, config, lib, userSet, ... }:

let
  palette = config.colorScheme.palette;
  inherit (userSet) slickbar simplebar clock24h;
in with lib; {
  services.mpd = {
    enable = true;
    musicDirectory = "/music";
    extraConfig = ''
      audio_output {
              type            "pulse"
              name            "pulse audio"
      }

      # Enable visualization
      audio_output {
          type                    "fifo"
          name                    "fifo"
          path                    "/tmp/mpd.fifo"
          format                  "44100:16:2"
      }
        #   audio_output {
    #     type "alsa"
    #     name "My ALSA"
    #     device			"hw:0,0"	# optional 
    #     format			"44100:16:2"	# optional
    #     mixer_type		"hardware"
    #     mixer_device	"default"
    #     mixer_control	"PCM"
    #   }
    '';
    # Optional:
    network.listenAddress = "any"; # if you want to allow non-localhost connections
  };
}
