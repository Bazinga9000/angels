{
  flake.aspects.nushell = {
    description = ''
      Enable and configure Nushell as the default shell.
    '';

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [ nushell ];
        environment.shells = with pkgs; [ nushell ];
        users.defaultUserShell = pkgs.nushell;
      };

    homeManager =
      { config, pkgs, ... }:
      {
        # Enable and configure Nushell via Home Manager
        programs.nushell = {
          enable = true;
          configFile.source = ./config.nu;
          shellAliases = {
            angels = "just --justfile=$'/home/(whoami)/angels/justfile'";
          };

          extraConfig = ''
            source nix-your-shell.nu
          '';
        };

        # Enable autocompletion in the shell via Carapace
        programs.carapace = {
          enable = true;
          enableNushellIntegration = true;
        };

        # Enable Starship for prompt
        programs.starship = {
          enable = true;
          enableNushellIntegration = true;
        };

        home.file."${config.xdg.configHome}/nushell/nix-your-shell.nu".source =
          pkgs.nix-your-shell.generate-config "nu";
      };
  };
}
