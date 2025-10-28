{
  flake.aspects.lua = {
    description = ''
      Tools for Lua
    '';

    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        lua
        love
      ];
    };
  };
}
