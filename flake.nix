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

    # Nixpkgs PR Patcher
    nixpkgs-patcher.url = "github:gepbird/nixpkgs-patcher";

    nixpkgs-patch-jugglinglab-desktop = {
      url = "https://github.com/NixOS/nixpkgs/pull/444855.diff";
      flake = false;
    };

    nixpkgs-patch-lovely-injector-update = {
      url = "https://github.com/NixOS/nixpkgs/pull/446993.diff";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    catppuccin,
    zen-browser,
    nixpkgs-patcher,
    ...
  } @inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
    in {
    nixosConfigurations = {
      metatron = nixpkgs-patcher.lib.nixosSystem {
        inherit system;
        specialArgs = inputs;
        modules = [
          ./common/configuration.nix
          ./common/overlays.nix
          ./common/packages.nix
          ./common/languages
          ./metatron
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager {
            home-manager.extraSpecialArgs = inputs;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "bak";
            home-manager.users.bazinga = { pkgs, ...}: {
              imports = [
                ./metatron/home
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
          ./jophiel/configuration.nix
          ./common/languages/python.nix
        ];
      };
    };
  };
}
