{
  flake.aspects.social = {
    description = ''
      Programs for socializing.
    '';

    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        vesktop # This is a system package to play nice with screensharing
      ];
    };

    homeManager = {pkgs, ...}: {
      home.packages = with pkgs; [
        element-desktop
      ];
    };
  };
}
