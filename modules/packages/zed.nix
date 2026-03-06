{
  flake.aspects.zed = {
    description = ''
      Configuration for the zed editor.
    '';

    homeManager =
      { pkgs, ... }:
      {
        programs.zed-editor = {
          enable = true;

          # Core Zed extensions
          extensions = [
            "nix"
            "toml"
            "just"
            "git-firefly"
            "html"
          ];

          package = pkgs.zed-editor.fhsWithPackages (
            ps: with ps; [
              libz
              openssl
            ]
          );

          userSettings = {
            ui_font_size = 16;
            buffer_line_height = "comfortable";
            buffer_font_size = 18;
          };
        };
      };
  };
}
