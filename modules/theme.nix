let
  catp-flavor = "mocha";
  catp-accent = "peach";
in
{inputs, ...}: {
  flake-file.inputs.catppuccin = {
    url = "github:catppuccin/nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects.theme = {
    description = ''
      Theme the system. Uses Catpuccin whenever possible.
    '';

    nixos = {
      imports = [
        inputs.catppuccin.nixosModules.catppuccin
      ];

      catppuccin.enable = true;
      catppuccin.flavor = catp-flavor;
      catppuccin.accent = catp-accent;
    };

    homeManager = {pkgs, ...}: {
      imports = [
        inputs.catppuccin.homeModules.catppuccin
      ];

      # Non-GTK: Catppuccin
      catppuccin.enable = true;
      catppuccin.flavor = catp-flavor;
      catppuccin.accent = catp-accent;

      # dconf Dark Mode (for the internet etc)
      dconf.enable = true;
      dconf.settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };

      # Catpuccin Cursor
      home.pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        name = "catppuccin-mocha-dark-cursors";
        size = 16;
        package = pkgs.catppuccin-cursors.mochaDark;
      };

    };
  };
}
