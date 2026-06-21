{ inputs, ... }:
{
  flake-file.inputs.millennium.url = "github:SteamClientHomebrew/Millennium/next?dir=packages/nix";

  flake.aspects.steam = {
    description = ''
      Steam and its helpers (Gamemode, Proton, Gamescope)
    '';

    nixos =
      { pkgs, ... }:
      {
        nixpkgs.overlays = [ inputs.millennium.overlays.default ];

        programs.steam = {
          enable = true;
          # build failure
          # package = pkgs.millennium-steam;
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

        # Enable NTSync kernel module for Wine/Proton
        boot.kernelModules = [ "ntsync" ];
      };
  };
}
