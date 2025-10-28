{
  flake.aspects.latex = {
    description = ''
      Tools for LaTeX
    '';

    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        texlive.combined.scheme-full
      ];
    };
  };
}
