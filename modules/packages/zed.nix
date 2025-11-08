{
  flake.aspects = {aspects, ...}: {
    zed = {
      description = ''
        Configuration for the zed editor.
      '';

      # Include baz9k aspect for Fairfax HD
      includes = [aspects.baz9k];

      nixos = {pkgs, ...}: {
        fonts.packages = with pkgs; [
          baz9k.kreative-kore-fonts
          google-fonts
        ];
      };

      homeManager = {pkgs, ...}: {
        programs.zed-editor = {
          enable = true;

          # Core Zed extensions
          extensions = ["nix" "toml" "just" "git-firefly" "html"];

          package = pkgs.zed-editor.fhsWithPackages (
            ps: with ps; [
              libz
              openssl
            ]
          );

          userSettings = {
            ui_font_family = "Quicksand";
            ui_font_size = 16;
            buffer_font_family = "Fairfax HD";
            buffer_line_height = "comfortable";
            buffer_font_size = 18;
          };
        };
      };
    };
  };
}
