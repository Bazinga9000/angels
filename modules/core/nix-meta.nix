{
  flake.aspects.nix-meta = {
    description = ''
      Configuration of Nix commands and the Nix Store
    '';

    nixos = {
      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

      # Enable experimental features (for flakes)
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      # Automatic garbage collection of the nix store
      nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };

      # Automatic optimization of the nix store
      nix.optimise.automatic = true;
      nix.optimise.dates = [ "07:00" ];
    };
  };
}
