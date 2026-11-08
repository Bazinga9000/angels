let
  mkPatch = diff: {
    url = "https://github.com/NixOS/nixpkgs/pull/${toString diff}.diff";
    flake = false;
  };
in {
  # If this module is empty, that means this configuration requires no patches to nixpkgs (for now)
  # To add a new patch, add the following
  # flake-file.inputs.nixpkgs-patch-XXXXXXXXX = mkPatch PULL_REQUEST_NUMBER;
  # and it will be automatically applied thanks to nixpkgs-patcher.
  #
  # NB: Be sure to `nix run .#write-flake` after removing a merged patch.
  # Otherwise the patch will remain in the inputs and won't build.
  flake-file.inputs.nixpkgs-patch-hytale = mkPatch 479368;
  flake-file.inputs.nixpkgs-patch-deadlock-mod-manager = mkPatch 576813;
}
