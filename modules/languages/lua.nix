{lib, ...}: {
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

    homeManager = {pkgs, ...}: {
      programs = {
        vscode.profiles.default.extensions = lib.optionals (pkgs?vscode-marketplace) (with pkgs.vscode-marketplace; [
          sumneko.lua
        ]);

        zed-editor.extensions = ["lua"];
      };
    };
  };
}
