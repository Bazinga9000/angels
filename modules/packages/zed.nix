{
  flake.aspects.zed = {
    description = ''
      Configuration for the zed editor.
    '';

    homeManager =
      { pkgs, lib, ... }:
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
            helix_mode = true;
            buffer_line_height = "comfortable";
            buffer_font_size = lib.mkForce 18;
          };
        };
      };
  };
}
