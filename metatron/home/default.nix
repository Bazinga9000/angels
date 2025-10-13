{config, pkgs, ...}: {
  imports = [
    ./home.nix
    ./theme.nix
    ./games.nix
    ./shell.nix
  ];
}
