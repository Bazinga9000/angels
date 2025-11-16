{ inputs, config, ... }:
{
  flake-file.inputs.nixpkgs-patcher.url = "github:gepbird/nixpkgs-patcher";

  # Generates a host using the nixos and home-manager parts of each provided flake aspect.
  # This generates a single-user host.
  # TODO: migrate this to den if i can figure out a way to bundle the user and home configs together like this does (maybe just custom instantiate?)
  flake.lib.make-host =
    host-cfg:
    assert builtins.isString host-cfg.system;
    assert builtins.isString host-cfg.stateVersion;
    assert builtins.isString host-cfg.hostName;
    assert builtins.isString host-cfg.userName;
    assert builtins.isList host-cfg.aspects;
    inputs.nixpkgs-patcher.lib.nixosSystem {
      nixpkgsPatcher.inputs = inputs;
      system = host-cfg.system;
      modules = (builtins.map (module: config.flake.modules.nixos.${module} or { }) host-cfg.aspects) ++ [
        config.flake.modules.nixos.core # Include core on every host
        config.flake.modules.nixos.${host-cfg.hostName} or { } # Auto-include any host-specific aspect if one exists

        {
          # Set hostname and stateversion
          networking.hostName = host-cfg.hostName;
          system.stateVersion = host-cfg.stateVersion;

          # Add the requested user as root:
          users.users.${host-cfg.userName} = {
            isNormalUser = true;
            extraGroups = [
              "networkmanager"
              "wheel"
            ];
            useDefaultShell = true;
          };
        }

        # Set up home-manager
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "bak";
          home-manager.users.bazinga =
            { pkgs, ... }:
            {
              imports =
                (builtins.map (module: config.flake.modules.homeManager.${module} or { }) host-cfg.aspects)
                ++ [
                  config.flake.modules.homeManager.core # always add core
                  {
                    home.username = host-cfg.userName;
                    home.homeDirectory = "/home/${host-cfg.userName}";
                    programs.home-manager.enable = true;
                    home.stateVersion = host-cfg.homeStateVersion or host-cfg.stateVersion; # set stateversion to match the system's if unspecified
                  }
                ];
            };
        }
      ];
    };
}
