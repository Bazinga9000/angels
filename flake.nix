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

    # Nix-Alien
    nix-alien.url = "github:thiagokokada/nix-alien";

    # Purescript Overlay
    purescript-overlay.url = "github:thomashoneyman/purescript-overlay";
    purescript-overlay.inputs.nixpkgs.follows = "nixpkgs";

    # Bizhawk
    bizhawk.url = "github:TASEmulators/BizHawk";
    bizhawk.flake = false;

    # Zen Browser
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    # My own package repo
    baz9k-pkgs.url = "github:Bazinga9000/baz9k-pkgs";
    baz9k-pkgs.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    catppuccin,
    zen-browser,
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
              self.inputs.baz9k-pkgs.overlays.default # baz9k-pkgs
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

          ./common/configuration.nix
          ./common/packages.nix
          ./common/env_variables.nix
          ./configuration.nix
          ./cosmic.nix # Cosmic DE
          ./nvidia.nix # the demon of babylon disguises himself with the coat of the righteous
          ./systemPackages.nix
          ./env_variables.nix
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
                catppuccin.homeModules.catppuccin
                zen-browser.homeModules.beta
              ];
            };
          }
        ];
      };

      jophiel = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit self; };
        modules = [
          ./common/configuration.nix
          ./common/packages.nix
          ./common/env_variables.nix
          ./jophiel/configuration.nix
        ];
      };
    };
  };
}
