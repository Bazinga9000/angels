{
  flake.aspects.haskell = {
    description = ''
      Tools for Haskell
    '';

    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        ghc
        stack
        haskellPackages.haskell-language-server
      ];
    };

    homeManager.programs.zed-editor.extensions = ["haskell"];
  };
}
