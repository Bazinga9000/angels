{
  flake.aspects =
    { aspects, ... }:
    {
      ghostty = {
        description = ''
          The Ghostty terminal and its configuration.
        '';

        includes = with aspects; [ baz9k ];

        nixos =
          { pkgs, ... }:
          {
            fonts.packages = with pkgs; [
              baz9k.kreative-kore-fonts
            ];
          };

        homeManager = {
          programs.ghostty.enable = true;
          programs.ghostty.settings = {
            font-family = "FairfaxHD";
            font-size = 14;
          };
        };
      };
    };
}
