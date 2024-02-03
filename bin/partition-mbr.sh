#!/bin/sh

parted /dev/sda -- mklabel msdos
parted /dev/sda -- mkpart primary 1MB -8GB
parted /dev/sda -- mkpart primary linux-swap -8GB 100%
