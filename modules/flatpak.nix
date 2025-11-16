{
  flake.aspects.flatpak = {
    description = ''
      Enable flatpak.
    '';

    nixos =
      { pkgs, ... }:
      {
        services.flatpak.enable = true;
        environment.systemPackages = with pkgs; [ flatpak ];
      };
  };
}
