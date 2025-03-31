{
  description = "Make the system config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    # Home Manager - Declarative dotfiles
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Catppuccin - A theme
    catppuccin.url = "github:catppuccin/nix";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";

    # VSCodium Extensions
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-vscode-extensions.inputs.nixpkgs.follows = "nixpkgs";

    # Nix-Alien
    nix-alien.url = "github:thiagokokada/nix-alien";

    # Purescript Overlay
    purescript-overlay.url = "github:thomashoneyman/purescript-overlay";
    purescript-overlay.inputs.nixpkgs.follows = "nixpkgs";

    # XIVLauncher-RB
    nixos-xivlauncher-rb.url = "github:drakon64/nixos-xivlauncher-rb";
    nixos-xivlauncher-rb.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    catppuccin,
    nixos-xivlauncher-rb,
    ...
  } @inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
    in {
    nixosConfigurations = {
      metatron = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit self; };
        modules = [

          # Nixpkgs Overlays Module
          ({ self, options, ... }: {
            # Enable the desired overlays
            nixpkgs.overlays = [
              self.inputs.nix-alien.overlays.default # nix-alien
              self.inputs.purescript-overlay.overlays.default # purescript
            ];

            # Make the chosen overlays apply globally, not just in the flake build
            /*
            nix.nixPath =
              [
                "nixpkgs=flake:nixpkgs:/nix/var/nix/profiles/per-user/root/channels"
                "nixpkgs-overlays=${./overlays-compat}"
              ];
            */
          })

          ./configuration.nix
          ./nvidia.nix # the demon of babylon disguises himself with the coat of the righteous
          ./systemPackages.nix
          ./env_variables.nix
          nixos-xivlauncher-rb.nixosModules.default
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager {
            home-manager.extraSpecialArgs = inputs;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "bak";
            home-manager.users.bazinga = { pkgs, ...}: {
              imports = [
                ./home.nix # General Home-Manager Config
                ./theme.nix # Appearance Config
                ./hyprland.nix # Hyprland
                ./waybar.nix # Waybar
                catppuccin.homeModules.catppuccin
              ];
            };
          }
        ];
      };
    };
  };
}
