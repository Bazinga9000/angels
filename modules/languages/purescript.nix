{inputs, lib, ...}: {
  flake-file.inputs.purescript-overlay = {
    url = "github:thomashoneyman/purescript-overlay";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects.purescript = {
    description = ''
      Tools for Purescript
    '';

    nixos = {pkgs, ...}: {
      # Add the purescript overlay
      nixpkgs.overlays = [
        inputs.purescript-overlay.overlays.default
      ];

      # Add the purescript packages
      environment.systemPackages = with pkgs; [
        purs
        spago-unstable
        purs-tidy-bin.purs-tidy-0_10_0
        purs-backend-es
      ];
    };

    homeManager = {pkgs, ...}: {
      programs = {
        vscode.profiles.default.extensions = lib.optionals (pkgs?vscode-marketplace) (with pkgs.vscode-marketplace; [
          nwolverson.ide-purescript
          nwolverson.language-purescript
          mvakula.vscode-purty
        ]);

        zed-editor.extensions = ["purescript"];
      };
    };
  };
}
