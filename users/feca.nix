let
  username = "feca";
  userHome = "/home/${username}";
  flakeDir = "${userHome}/nixos";
  waybarStyle = "default"; # simplebar, slickbar, or default
in {
  # User Variables
  inherit username;
  inherit userHome;
  editor = "hx";
  gitUsername = "Enpassant";
  gitEmail = "enpassant.prog@gmail.com";
  theme = "gigavolt";
  slickbar = if waybarStyle == "slickbar" then true else false;
  simplebar = if waybarStyle == "simplebar" then true else false;
  borderAnim = true;
  #browser = "firefox";
  browser = "brave";
  wallpaperGit = "https://gitlab.com/Zaney/my-wallpapers.git"; # This will give you my wallpapers
  # ^ (use as is or replace with your own repo - removing will break the wallsetter script)
  wallpaperDir = "${userHome}/Pictures/Wallpapers";
  screenshotDir = "${userHome}/Pictures/Screenshots";
  flakeDir = "${flakeDir}";
  terminal = "foot"; 
  # terminal = "ghostty";
  vm = "sway";
  # vm = "hyprland";

  # System Settings
  toggleScript="toggle_input_sinks.sh";
  flakeUser="";
  clock24h = true;
  theLocale = "hu_HU.UTF-8";
  theKBDLayout = "hu,hu(oldhunlig)";
  theKBDVariant = "us";
  theKBDOptions = "compose:sclk";
  theLCVariables = "hu_HU.UTF-8";
  theTimezone = "Europe/Budapest";
  theShell = "zsh"; # Possible options: bash, zsh
  theKernel = "default"; # Possible options: default, latest, lqx, xanmod, zen
  # This is for running NixOS
  # On a tmpfs or root on RAM
  # You Most Like Want This -> false
  impermanence = true; # This should be set to false unless you know what your doing!
  sdl-videodriver = "x11"; # Either x11 or wayland ONLY. Games might require x11 set here
  # For Hybrid Systems intel-nvidia
  # Should Be Used As gpuType
  cpuType = "intel";
  gpuType = "amd";

  # Nvidia Hybrid Devices
  # ONLY NEEDED FOR HYBRID
  # SYSTEMS!
  intel-bus-id = "PCI:0:2:0";
  nvidia-bus-id = "PCI:14:0:0";

  # NTP & HWClock Settings
  ntp = true;
  localHWClock = false;

  # Enable Printer & Scanner Support
  printer = false;

  # Enable Flatpak & Larger Programs
  flatpak = false;
  kdenlive = false;
  blender = false;

  # Enable Support For
  # Logitech Devices
  logitech = false;

  # Enable Terminals
  # If You Disable All You Get Kitty
  wezterm = false;
  alacritty = true;
  foot = true;
  kitty = true;
  ghostty = true;

  # Enable Python & PyCharm
  python = false;
}
