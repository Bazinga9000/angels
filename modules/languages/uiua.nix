{lib, ...}: {
  flake.aspects.uiua = {
    description = ''
      Tools for Uiua
    '';

    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        (uiua-unstable.override {
          webcamSupport = true;
          windowSupport = true;
        })
      ];

      fonts.packages = with pkgs; [
        uiua386
      ];
    };

    homeManager = {pkgs, ...}: {
      programs = {
        vscode.profiles.default.extensions = lib.optionals (pkgs?vscode-marketplace) (with pkgs.vscode-marketplace; [
          uiua-lang.uiua-vscode
        ]);

        vscode.profiles.default.userSettings = {
          "[uiua]" = {
             "editor.fontFamily" = "Uiua386, Fairfax HD, monospace";
          };
        };

        zed-editor.extensions = ["uiua"];
      };
    };
  };
}
