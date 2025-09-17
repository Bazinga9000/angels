{config, pkgs, ...}: {
  imports = [
    ./c_cpp.nix
    ./haskell.nix
    ./latex.nix
    ./lua.nix
    ./nix.nix
    ./purescript.nix
    ./python.nix
    ./rust.nix
  ];
}
