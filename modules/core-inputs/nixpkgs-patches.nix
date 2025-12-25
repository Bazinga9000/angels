{
  # If this module is empty, that means this configuration requires no patches to nixpkgs (for now)
  # To add a new patch, add the following
  # flake-file.inputs.nixpkgs-patch-XXXXXXXXX = {
  #   url = "https://github.com/NixOS/nixpkgs/pull/YYYYYY.diff";
  #   flake = false;
  # }
  # and it will be automatically applied thanks to nixpkgs-patcher.
  #
  # NB: Be sure to `nix run .#write-flake` after removing a merged patch.
  # Otherwise the patch will remain in the inputs and won't build.
}
