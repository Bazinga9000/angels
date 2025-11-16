{ lib, ... }:
{
  flake.aspects.rust = {
    description = ''
      Tools for Rust
    '';

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          rustup
        ];
      };

    homeManager =
      { pkgs, ... }:
      {
        programs = {
          vscode.profiles.default.extensions = lib.optionals (pkgs ? vscode-marketplace) (
            with pkgs.vscode-marketplace;
            [
              rust-lang.rust-analyzer
            ]
          );

          zed-editor.extensions = [ "rust-snippets" ];
        };
      };
  };
}
