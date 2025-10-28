{inputs, ...}: {
  flake-file.inputs.nix-alien = {
    url = "github:thiagokokada/nix-alien";
  };

  flake.aspects.nix-alien = {
    description = ''
      Enables nix-alien for running non-NixOS binaries.
    '';

    nixos = {pkgs, ...}: {
      nixpkgs.overlays = [
        inputs.nix-alien.overlays.default
      ];

      environment.systemPackages = [pkgs.nix-alien];
    };
  };
}
