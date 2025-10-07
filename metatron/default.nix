{config, pkgs, ...}: {
  imports = [
    ./configuration.nix
    ./cosmic.nix
    ./env_variables.nix
    ./hardware-configuration.nix
    ./nvidia.nix
    ./steam.nix
    ./systemPackages.nix
  ];
}
