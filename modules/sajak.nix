{ inputs, ... }:
{
  flake-file.inputs.sajak = {
    url = "github:Bazinga9000/sajak";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects.sajak = {
    description = ''
      Configuration for sajak, my word-finding program. 
    '';

    nixos =
      { pkgs, ... }:
      {
        nixpkgs.overlays = [
          inputs.sajak.overlays.default
        ];

        imports = [
          inputs.sajak.nixosModules.default
        ];

        environment.systemPackages = [
          pkgs.sajak
        ];
        # services.sajak-http.enable = true;
      };
  };
}
