{
  flake.aspects = {aspects, ...}: {
    hyfetch = {
      description = ''
        Set up and configure Hyfetch (and its fastfetch backend).
      '';

      includes = [aspects.nushell];

      homeManager = {pkgs, ...}: {
        programs.hyfetch = {
          enable = true;
          settings = {
            preset = "nonbinary";
            mode = "rgb";
            color_align.mode = "horizontal";
            lightness = 0.75;
            backend = "fastfetch";
            args = null;
            distro = "nixos_small";
            pride_month_disable = false;
            custom_ascii_path = null;
          };
        };

        programs.fastfetch = {
          enable = true;
          settings = {
            modules = [
              "title"
              "separator"
              "os"
              {
                type = "command";
                key = "Generation";
                text = "readlink /nix/var/nix/profiles/system | cut -d- -f2";
              }
              {
                type = "command";
                key = "Nixpkgs";
                text = "nu ${../../scripts/hyfetch_nixpkgs.nu}";
              }
              "uptime"
              "cpuusage"
              "memory"
              "disk"
              "datetime"
              {
                type = "weather";
                timeout = 1000;
                outputFormat = "%t+-+%C+";
              }
            ];
          };
        };

        programs.nushell.extraConfig = ''
          if (not $nu.is-login) { hyfetch }
        '';
      };
    };
  };
}
