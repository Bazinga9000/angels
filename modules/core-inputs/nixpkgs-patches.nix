{
  # Lovely injector update to get Balatro to build
  flake-file.inputs.nixpkgs-patch-lovely-injector-update = {
    url = "https://github.com/NixOS/nixpkgs/pull/446993.diff";
    flake = false;
   };
}
