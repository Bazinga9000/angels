{ inputs, lib, ... }:
{
  flake-file.inputs.uiua = {
    url = "github:uiua-lang/uiua";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects.uiua = {
    description = ''
      Tools for Uiua
    '';

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          inputs.uiua.packages.${pkgs.stdenv.hostPlatform.system}.default
        ];

        fonts.packages = with pkgs; [
          inputs.uiua.packages.${pkgs.stdenv.hostPlatform.system}.fonts
        ];
      };

    homeManager =
      { pkgs, ... }:
      {
        programs = {
          vscode.profiles.default.extensions = lib.optionals (pkgs ? vscode-marketplace) (
            with pkgs.vscode-marketplace;
            [
              uiua-lang.uiua-vscode
            ]
          );

          vscode.profiles.default.userSettings = {
            "[uiua]" = {
              "editor.fontFamily" = "Uiua386, Fairfax HD, monospace";
            };
          };

          zed-editor.extensions = [ "uiua" ];
        };
      };
  };
}
