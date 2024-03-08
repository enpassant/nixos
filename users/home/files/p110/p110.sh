#!/usr/bin/env sh
DIR=$(dirname "$0")
nix-shell $DIR --command "source ~/data/accounts/kasa.sh; $DIR/p110.py $*"
