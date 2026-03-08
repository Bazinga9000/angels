{ inputs, config, ... }:
{
  flake-file.inputs.stylix = {
    url = "github:nix-community/stylix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects =
    { aspects, ... }:
    {
      theme = {

        includes = with aspects; [ baz9k ];

        description = ''
          Theme the system with Stylix. Uses Papercolor Dark whenever possible.
        '';

        nixos =
          { pkgs, ... }:
          {
            imports = [
              inputs.stylix.nixosModules.stylix
            ];

            stylix.enable = true;
            stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/chinoiserie-midnight.yaml";
            stylix.image = ../assets/wallpapers/doom_sasasu_interphos.png;

            stylix.fonts.sansSerif = {
              package = pkgs.google-fonts;
              name = "Quicksand";
            };

            stylix.fonts.monospace = {
              package = pkgs.kreative-kore-fonts;
              name = "Fairfax HD";
            };

            stylix.cursor = {
              name = "volantes_cursors";
              size = 16;
              package = pkgs.volantes-cursors;
            };

            # Use HyperFluent GRUB theme
            stylix.targets.grub.enable = false;
            boot.loader.grub.theme = pkgs.stdenv.mkDerivation {
              pname = "hyperfluent-grub-themes";
              version = "1.0.1";
              src = pkgs.fetchFromGitHub {
                owner = "Coopydood";
                repo = "HyperFluent-GRUB-Theme";
                rev = "v1.0.1";
                hash = "sha256-zryQsvue+YKGV681Uy6GqnDMxGUAEfmSJEKCoIuu2z8=";
              };
              installPhase = "cp -r nixos $out";
            };
          };

        homeManager =
          { pkgs, lib, ... }:
          {
            # set profiles for zen browser
            stylix.targets.zen-browser.profileNames = [ "default" ];

            # dconf Dark Mode (for the internet etc)
            dconf.enable = true;
            dconf.settings = {
              "org/gnome/desktop/interface" = {
                color-scheme = lib.mkForce "prefer-dark";
              };
            };
          };
      };
    };
}
