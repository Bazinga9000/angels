{ lib, ... }:
{
  flake.aspects.nix = {
    description = ''
      Tools for Nix (the language)
    '';

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          nil
          nixd
          nixfmt
        ];
      };

    homeManager =
      { pkgs, ... }:
      {
        programs = {
          vscode.profiles.default.extensions = lib.optionals (pkgs ? vscode-marketplace) (
            with pkgs.vscode-marketplace;
            [
              bbenoist.nix
              jnoortheen.nix-ide
            ]
          );

          zed-editor.extensions = [ "nix" ];
        };
      };
  };
}
