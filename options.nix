let
  username = "feca";
  hostname = "nixos";
  userHome = "/home/${username}";
  flakeDir = "${userHome}/nixos";
  waybarStyle = "default"; # simplebar, slickbar, or default
in {
  # User Variables
  username = "${username}";
  hostname = "${hostname}";
  gitUsername = "Enpassant";
  gitEmail = "enpassant.prog@gmail.com";
  theme = "gigavolt";
  slickbar = if waybarStyle == "slickbar" then true else false;
  simplebar = if waybarStyle == "simplebar" then true else false;
  borderAnim = true;
  browser = "firefox";
  wallpaperGit = "https://gitlab.com/Zaney/my-wallpapers.git"; # This will give you my wallpapers
  # ^ (use as is or replace with your own repo - removing will break the wallsetter script) 
  wallpaperDir = "${userHome}/Pictures/Wallpapers";
  screenshotDir = "${userHome}/Pictures/Screenshots";
  flakeDir = "${flakeDir}";
  terminal = "alacritty"; # This sets the terminal that is used by the hyprland terminal keybinding
  vm = "sway";

  # System Settings
  clock24h = true;
  theLocale = "hu_HU.UTF-8";
  theKBDLayout = "us";
  theSecondKBDLayout = "altgr-intl";
  theKBDVariant = "compose:sclk";
  theLCVariables = "hu_HU.UTF-8";
  theTimezone = "Europe/Budapest";
  theShell = "zsh"; # Possible options: bash, zsh
  theKernel = "default"; # Possible options: default, latest, lqx, xanmod, zen
  # This is for running NixOS
  # On a tmpfs or root on RAM
  # You Most Like Want This -> false

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
  kitty = false;

  # Enable Python & PyCharm
  python = false;
}
