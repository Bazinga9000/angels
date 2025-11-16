{ lib, ... }:
{
  flake.aspects.haskell = {
    description = ''
      Tools for Haskell
    '';

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          ghc
          stack
          haskellPackages.haskell-language-server
        ];
      };

    homeManager =
      { pkgs, ... }:
      {
        programs = {
          vscode.profiles.default.extensions = lib.optionals (pkgs ? vscode-marketplace) (
            with pkgs.vscode-marketplace;
            [
              haskell.haskell
              justusadam.language-haskell
            ]
          );

          zed-editor.extensions = [ "haskell" ];
        };
      };
  };
}
