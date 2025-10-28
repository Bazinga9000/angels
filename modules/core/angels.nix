{
  flake.aspects.angels = {
    description = ''
      Packages and configurations to interface with this flake
    '';

    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        git
        gh
        just
        nh
      ];
    };
  };
}
