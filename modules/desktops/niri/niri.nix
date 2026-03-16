{ inputs, ... }:
{
  flake-file.inputs = {
    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.noctalia-qs.follows = "noctalia-qs";
    };

    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.aspects.niri-cache = {
    descritpion = ''
      Seperate aspect for manually enabling the Niri flake's cache. 
      When setting up a new system, enable this aspect, rebuild, then enable the full niri aspect.
    '';

    nixos.nix.settings = {
      substituters = [ "https://niri.cachix.org" ];
      trusted-public-keys = [ "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964=" ];
    };
  };

  flake.aspects.niri = {
    description = ''
      Enable the Niri window manager with Noctalia shell.
    '';

    nixos =
      { pkgs, lib, ... }:
      {
        imports = [
          inputs.niri-flake.nixosModules.niri
        ];

        networking.networkmanager.enable = true;
        hardware.bluetooth.enable = true;
        services.power-profiles-daemon.enable = true;
        services.upower.enable = true;
        services.gvfs.enable = true;

        # Enable cosmic-greeter and niri
        services.displayManager.cosmic-greeter.enable = true;
        programs.niri.enable = true;

        # Wayland Environment Fixes
        environment.sessionVariables.NIXOS_OZONE_WL = "1"; # Electron

        # Enable evolution-data-server for calendar support
        services.gnome.evolution-data-server.enable = true;

        environment.systemPackages = with pkgs; [
          # Enable XWayland support
          xwayland-satellite

          # Enable nautilus for file management
          nautilus
          nautilus-python
        ];
      };

    homeManager =
      { pkgs, ... }:
      {
        imports = [
          inputs.noctalia.homeModules.default
        ];

        # Enable zathura for PDFs
        programs.zathura.enable = true;

        # Enable Noctalia shell and the systemd service
        programs.noctalia-shell = {
          enable = true;
          package = (
            # Override package for calendar support
            inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
              calendarSupport = true;
            }
          );
        };

        # Configure Niri settings
        programs.niri.settings = {
          # Disable hot corners
          gestures.hot-corners.enable = false;

          # Enable compose key on capslock
          input.keyboard.xkb.options = "compose:caps";

          # Force eDP-1 to 0,0 if it exists (this is the laptop monitor)
          outputs."eDP-1".position = {
            x = 0;
            y = 0;
          };

          spawn-at-startup = [
            {
              command = [
                "noctalia-shell" # Spawn Noctalia on startup
              ];
            }
          ];

          window-rules = [
            {
              matches = [ { app-id = ".*"; } ];
              geometry-corner-radius = {
                top-left = 20.0;
                top-right = 20.0;
                bottom-left = 20.0;
                bottom-right = 20.0;
              };
              clip-to-geometry = true;
            }
            {
              matches = [
                {
                  app-id = "steam";
                  title = "^notificationtoasts_\\d+_desktop$";
                }
              ];
              default-floating-position = {
                x = 10;
                y = 10;
                relative-to = "bottom-right";
              };
            }
          ];
        };
      };
  };
}
