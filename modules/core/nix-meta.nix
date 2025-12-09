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

      programs.nh = {
        enable = true;
        clean.enable = true;
        clean.extraArgs = "--keep 3 --keep-since 30d --optimise";
      };

      # Automatic optimization of the nix store
      nix.optimise.automatic = true;
      nix.optimise.dates = [ "07:00" ];
    };
  };
}
