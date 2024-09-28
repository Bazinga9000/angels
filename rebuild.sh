#!/usr/bin/env sh
echo "Running nixos-rebuild"
sudo nixos-rebuild switch --flake .#metatron
