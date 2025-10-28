{
  flake.aspects.steam = {
    description = ''
      Steam and its helpers (Gamemode, Proton, Gamescope)
    '';

    nixos = {pkgs, ...}: {
      programs.steam = {
          enable = true;
          protontricks.enable = true;
          extest.enable = true;
          remotePlay.openFirewall = true;
          dedicatedServer.openFirewall = true;
          localNetworkGameTransfers.openFirewall = true;
          extraCompatPackages = with pkgs; [
              proton-ge-bin
          ];
      };
      programs.gamemode.enable = true;
      programs.gamescope.enable = true;
    };
  };
}
