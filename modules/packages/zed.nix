{
  flake.aspects.zed = {
    description = ''
      Configuration for the zed editor.
    '';

    nixos = { pkgs, ... }: {
      programs.nix-ld = {
        enable = true;
        libraries = with pkgs; [
          zlib
          openssl
        ];
      };
    };

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

          userSettings = {
            helix_mode = true;
            buffer_line_height = "comfortable";
            buffer_font_size = lib.mkForce 18;
          };
        };
      };
  };
}
