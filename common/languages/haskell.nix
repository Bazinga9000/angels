{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ghc
    stack
    haskellPackages.haskell-language-server
  ];
}
