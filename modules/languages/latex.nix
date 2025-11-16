{ lib, ... }:
{
  flake.aspects.latex = {
    description = ''
      Tools for LaTeX
    '';

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          texlive.combined.scheme-full
        ];
      };

    homeManager =
      { pkgs, ... }:
      {
        programs = {
          vscode.profiles.default.extensions = lib.optionals (pkgs ? vscode-marketplace) (
            with pkgs.vscode-marketplace;
            [
              james-yu.latex-workshop
            ]
          );

          zed-editor.extensions = [ "latex" ];
        };
      };
  };
}
