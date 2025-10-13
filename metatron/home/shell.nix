{ pkgs, ... }:
{
  # Nushell
  programs.nushell = {
    enable = true;
    configFile.source = ../../config/nu/config.nu;
    shellAliases = {
      metatron = "just --justfile=/home/bazinga/metatron/justfile"; # Global command to interact with this config
    };
  };

  # Carapace
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };
}
