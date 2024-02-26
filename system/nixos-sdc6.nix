{ pkgs, ... }:
{
  hardware = "-sdc6";
  hostname = "nixos-sdc6";
  extraPackages = with pkgs; [
    libreoffice-qt
    hunspell
    hunspellDicts.hu_HU
    hunspellDicts.en_US
  ];
}
