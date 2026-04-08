{ inputs, ... }:
{
  flake-file.inputs.agenix = {
    url = "github:ryantm/agenix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects.agenix = {
    description = ''
      Enables agenix for provisioning of secrets.
    '';

    nixos =
      { pkgs, ... }:
      {
        imports = [
          inputs.agenix.nixosModules.default
        ];

        environment.systemPackages = [ inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default ];
      };
  };
}
