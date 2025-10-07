{ self, options, ... }: {
  # Enable the desired overlays
  nixpkgs.overlays = [
    self.inputs.nix-alien.overlays.default # nix-alien
    self.inputs.purescript-overlay.overlays.default # purescript
    self.inputs.baz9k-pkgs.overlays.default # baz9k-pkgs
  ];

  # Make the chosen overlays apply globally, not just in the flake build
  /*
  nix.nixPath =
    [
      "nixpkgs=flake:nixpkgs:/nix/var/nix/profiles/per-user/root/channels"
      "nixpkgs-overlays=${./overlays-compat}"
    ];
  */
}
