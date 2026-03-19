{
  flake.aspects.ghostty = {
    description = ''
      The Ghostty terminal and its configuration.
    '';

    homeManager =
      { lib, ... }:
      {
        programs.ghostty.enable = true;
        programs.ghostty.settings = {
          font-size = lib.mkForce 14;
        };
      };
  };
}
