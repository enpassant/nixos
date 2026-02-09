# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, sysSet, ... }:

let
  inherit (sysSet)
    hostname hardware
    vm username
    theLocale theTimezone displayUsername
    theShell libreOffice
    theLCVariables theKBDLayout theKBDVariant theKBDOptions;
  swayConfig = pkgs.writeText "greetd-sway-config" ''
    # `-l` activates layer-shell mode. Notice that `swaymsg exit` will run after gtkgreet.
    exec "${pkgs.greetd.gtkgreet}/bin/gtkgreet -l; swaymsg exit"
    bindsym Mod4+shift+e exec swaynag \
      -t warning \
      -m 'What do you want to do?' \
      -b 'Poweroff' 'systemctl poweroff' \
      -b 'Reboot' 'systemctl reboot'
  '';    
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration${hardware}.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.extraModprobeConfig = ''
    options snd-hda-intel model=alc283-headset,dell-headset-multi
  '';

  networking.hostName = "${hostname}"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Budapest";

  # Select internationalisation properties.
  i18n.defaultLocale = "${theLocale}";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "${theLCVariables}";
    LC_IDENTIFICATION = "${theLCVariables}";
    LC_MEASUREMENT = "${theLCVariables}";
    LC_MONETARY = "${theLCVariables}";
    LC_NAME = "${theLCVariables}";
    LC_NUMERIC = "${theLCVariables}";
    LC_PAPER = "${theLCVariables}";
    LC_TELEPHONE = "${theLCVariables}";
    LC_TIME = "${theLCVariables}";
  };

  console.keyMap = "${theKBDLayout}";

  programs.nix-ld.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  security.polkit.enable = true;
  hardware.graphics.enable = true;

  security.pki.certificateFiles = [ ./files/lets-encrypt-r3.pem ];

  # Enable the Sway Window Manager.
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${pkgs.sway}/bin/sway --config ${swayConfig}";
  #     };
  #   };
  # };

  # environment.etc."greetd/environments".text = ''
  #   sway
  #   Hyprland
  # '';
  
  # services.xserver.displayManager.gdm.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  # services.xserver.displayManager.defaultSession = "${vm}";

  programs.niri.enable = true;
  services.displayManager.sessionPackages = [ pkgs.niri ];

  services.desktopManager.gnome.enable = true;
  # xdg.portal = {
  #   enable = true;
  #   wlr.enable = true;
  #   # gtk portal needed to make gtk apps happy
  #   extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  # };

  programs.dconf.enable = true;
  # programs.hyprland = {
  #   enable = true;
  #   package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  #   portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  #   xwayland.enable = true;
  # };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "${theKBDLayout}";
    variant = "${theKBDVariant}";
    options = "${theKBDOptions}";
  };

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [ gutenprint canon-cups-ufr2 cups-filters ];
    browsing = true;
    browsedConf = ''
BrowseDNSSDSubTypes _cups,_print
BrowseLocalProtocols all
BrowseRemoteProtocols all
CreateIPPPrinterQueues All

BrowseProtocols all
    '';
  };
  
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${username}" = {
    isNormalUser = true;
    description = "${displayUsername}";
    extraGroups = [ "networkmanager" "wheel" "polkituser" "audio" "podman" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    ];
  };
  users.users."peter" = {
    isNormalUser = true;
    description = "Kálmán Péter";
    extraGroups = [ "networkmanager" "wheel" "polkituser" "audio" "podman" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    ];
  };
  users.defaultUserShell = pkgs.zsh;

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    lf
    helix
    tmux
    git
    mc
    pulseaudio
    openvpn
    waypipe
    podman-compose
    home-manager
  ] ++ (if libreOffice == true then
    [
      libreoffice-qt
      hunspell
      hunspellDicts.hu_HU
      hunspellDicts.en_US
      gimp
    ]
  else []);
  environment.shells = [ pkgs.zsh ];
  environment.etc."wireplumber/main.lua.d/90-suspend-timeout.lua" = {
    text = ''
      apply_properties = {
        ["session.suspend-timeout-seconds"] = 0
      }
    '';
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.zsh.enable = true;

  # List services that you want to enable:

  services.minidlna.enable = true;
  services.minidlna.settings = {
    friendly_name = "NixOS-DLNA";

    #     https://mylinuxramblings.wordpress.com/2016/02/19/mini-how-to-installing-minidlna-in-ubuntu/
    #    "A" for audio    (eg. media_dir=A,/var/lib/minidlna/music)
    #    "P" for pictures (eg. media_dir=P,/var/lib/minidlna/pictures)
    #    "V" for video    (eg. media_dir=V,/var/lib/minidlna/videos)
    #    "PV" for pictures and video (eg. media_dir=PV,/var/lib/minidlna/digital_camera)

    media_dir = [
      "PV,/media/data/user/mm/Pictures" # Music files are located here
      "A,/media/data/user/mm/mp3" # Audio files are here
      "PV,/media/data/user/mm/video" # Music files are located here
    ];
 
    inotify = "yes";
    log_level = "error";
  };

  users.users.minidlna = {
    extraGroups =
      [ "users" "samba" "wheel" ]; # so minidlna can access the files.
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  services.openssh = {
    enable = true;
    ports = [ 3922 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "feca" ];
    };
  };
  
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 3000 1080 1443 8080 9090 9999 8200 ];
    allowedUDPPorts = [ 1900 51820 ];
  };

  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  nix.settings = {
    # substituters = ["https://hyprland.cachix.org"];
    # trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    experimental-features = [ "nix-command" "flakes" ];
  };
}
