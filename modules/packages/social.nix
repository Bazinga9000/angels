{
  flake.aspects.social = {
    description = ''
      Programs for socializing.
    '';

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          element-desktop
        ];

        programs.vesktop.enable = true;
      };
  };
}
