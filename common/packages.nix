{ config, pkgs, ... }:
{
  # Packages that every host wants
  environment.systemPackages = with pkgs; [
     vim
     wget
     git
     gh
     nushell # This module also sets nushell as the default user shell
     nh
  ];

  programs.firefox.enable = true;

  users.defaultUserShell = pkgs.nushell;
}
