{
  flake.aspects.nushell = {
    description = ''
      Enable and configure Nushell as the default shell.
    '';

    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [ nushell ];
      users.defaultUserShell = pkgs.nushell;
    };

    homeManager = {
      # Enable and configure Nushell via Home Manager
      programs.nushell = {
        enable = true;
        configFile.source = ./config.nu;
        shellAliases = {
          angels = "just --justfile=$'/home/(whoami)/angels/justfile'";
        };
      };

      # Enable autocompletion in the shell via Carapace
      programs.carapace = {
        enable = true;
        enableNushellIntegration = true;
      };
    };
  };
}
