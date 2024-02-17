#!/bin/sh

mkfs.ext4 -L nixos /dev/sda1
mkswap -L swap /dev/sda2
swapon /dev/sda2
mount /dev/disk/by-label/nixos /mnt
nixos-generate-config --root /mnt
# nano /mnt/etc/nixos/configuration.nix
# nixos-install --fake .#$1
# reboot
