{
  flake.aspects.c-cpp = {
    description = ''
      Tools for Nix (the language)
    '';

    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        nil
      ];
    };
  };
}
