{lib, ...}: {
  flake.aspects.latex = {
    description = ''
      Tools for LaTeX
    '';

    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        texlive.combined.scheme-full
      ];
    };

    homeManager = {pkgs, ...}: {
      programs = {
        vscode.profiles.default.extensions = lib.optionals (pkgs?vscode-marketplace) (with pkgs.vscode-marketplace; [
          haskell.haskell
          justusadam.language-haskell
        ]);

        zed-editor.extensions = ["latex"];
      };
    };
  };
}
