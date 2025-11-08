{
  flake.aspects.c-cpp = {
    description = ''
      Tools for Nix (the language)
    '';

    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        nil
        nixd
      ];
    };

    homeManager.programs.zed-editor.extensions = ["nix"];
  };
}
