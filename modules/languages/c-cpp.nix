{
  flake.aspects.c-cpp = {
    description = ''
      Tools for C/C++
    '';

    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        gcc
        libgcc
      ];
    };
  };
}
