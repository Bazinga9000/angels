{ inputs, ... }:
{
  flake-file.inputs.baz9k-pkgs = {
    url = "github:Bazinga9000/baz9k-pkgs";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects.baz9k = {
    description = ''
      Enables the overlay for my custom package repository
    '';

    nixos = {
      nixpkgs.overlays = [
        inputs.baz9k-pkgs.overlays.default
      ];
    };
  };
}
