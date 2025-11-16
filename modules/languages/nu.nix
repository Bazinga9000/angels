{lib, ...}: {
  flake.aspects.c-cpp = {
    description = ''
      Tools for Nu
    '';

    homeManager = {pkgs, ...}: {
      programs = {
        vscode.profiles.default.extensions = lib.optionals (pkgs?vscode-marketplace) (with pkgs.vscode-marketplace; [
          thenuprojectcontributors.vscode-nushell-lang
        ]);

        zed-editor.extensions = ["nu"];
      };
    };
  };
}
