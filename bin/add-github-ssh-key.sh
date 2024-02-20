#!/usr/bin/bash
exec ssh-agent bash -c " \
    eval \"$(ssh-agent -s)\" \
    ssh-add ~/.ssh/id_ed25519"

echo "Set remote repository for nixos git repository:"
echo "git remote set-url origin git@github.com:enpassant/nixos.git"
