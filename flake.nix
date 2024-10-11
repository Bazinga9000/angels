{
  description = "Make the system config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    
    # Home Manager - Declarative dotfiles
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Catppuccin - A theme
    catppuccin.url = "github:catppuccin/nix";
    
    # AGS - Bar/Notifications/Applauncher
    ags.url = "github:Aylur/ags";
    ags.inputs.nixpkgs.follows = "nixpkgs";
    
    # VSCodium Extensions
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-vscode-extensions.inputs.nixpkgs.follows = "nixpkgs";

    # Nix-Alien
    nix-alien.url = "github:thiagokokada/nix-alien";
    nix-alien.inputs.nixpkgs.follows = "nixpkgs";

    # Purescript Overlay
    purescript-overlay.url = "github:thomashoneyman/purescript-overlay";
    purescript-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self, 
    nixpkgs, 
    home-manager, 
    catppuccin, 
    ags, 
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
            nix.nixPath =
              # Prepend default nixPath values.
              options.nix.nixPath.default ++
              # Append our nixpkgs-overlays.
              [ "nixpkgs-overlays=${./overlays-compat}" ];
          })

          ./configuration.nix
          ./nvidia.nix # the demon of babylon disguises himself with the coat of the righteous
          ./systemPackages.nix 
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
                catppuccin.homeManagerModules.catppuccin
                ags.homeManagerModules.default
              ];
            };
          }
        ];
      };
    };
  };
}
