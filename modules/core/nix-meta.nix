{ inputs, ... }:
{

  flake-file.inputs.nix-index-database = {
    url = "github:nix-community/nix-index-database";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects.nix-meta = {
    description = ''
      Configuration of Nix commands and the Nix Store
    '';

    nixos = {
      imports = [
        inputs.nix-index-database.nixosModules.default
      ];

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

      # Add comma for running nixpkgs without installing
      programs.nix-index-database.comma.enable = true;
    };
  };
}
