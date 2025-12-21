{ lib, ... }:
{
  flake.aspects.typst = {
    description = ''
      Tools for Typst
    '';

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          typst
        ];
      };

    homeManager =
      { pkgs, ... }:
      {
        programs = {
          vscode.profiles.default.extensions = lib.optionals (pkgs ? vscode-marketplace) (
            with pkgs.vscode-marketplace;
            [
              myriad-dreamin.tinymist
            ]
          );

          zed-editor.extensions = [ "typst" ];
        };
      };
  };
}
