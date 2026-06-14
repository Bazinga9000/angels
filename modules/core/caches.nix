{
  flake.aspects.caches = {
    description = ''
      Enable various binary caches.
    '';

    nixos.nix.settings = {
      # Add more caches you want globally on by all systems here
      substituters = [ ];
      trusted-public-keys = [ ];
    };
  };
}
