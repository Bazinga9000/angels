#!/usr/bin/env sh
echo "Running nix flake update"
nix flake update
./rebuild.sh
