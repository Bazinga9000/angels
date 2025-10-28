{
  flake.aspects.mathematica = {
    description = ''
      Tools for Mathematica
    '';

    nixos = {pkgs, ...}: {
      # TODO: declaratively require mathematica file here

      environment.systemPackages = with pkgs; [
        mathematica
      ];
    };
  };
}
