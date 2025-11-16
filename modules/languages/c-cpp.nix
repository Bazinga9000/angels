{ lib, ... }:
{
  flake.aspects.c-cpp = {
    description = ''
      Tools for C/C++
    '';

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          gcc
          libgcc
        ];
      };

    homeManager =
      { pkgs, ... }:
      {
        programs = {
          vscode.profiles.default.extensions = lib.optionals (pkgs ? vscode-marketplace) (
            with pkgs.vscode-marketplace;
            [
              ms-vscode.cpptools-extension-pack
            ]
          );
        };
      };
  };
}
