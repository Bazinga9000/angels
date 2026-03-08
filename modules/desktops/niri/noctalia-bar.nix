{
  flake.aspects.niri.homeManager =
    { pkgs, ... }:
    {
      programs.noctalia-shell.settings.bar = {
        widgets = {
          left = [
            {
              id = "Workspace";
            }
            {
              id = "SystemMonitor";
              compactMode = false;
              showNetworkStats = true;

              showDiskUsage = true;
              showDiskAvailable = true;
              diskPath = "/home";
            }
            {
              id = "ActiveWindow";
            }
            {
              id = "MediaMini";
            }
          ];
          center = [
            {
              id = "Clock";
              formatHorizontal = "HH:mm:ss ddd, MMM dd";
            }
          ];
          right = [
            {
              id = "Tray";
            }
            {
              id = "NotificationHistory";
            }
            {
              id = "CustomButton";
              icon = "snowflake";
              ipcIdentifier = "nixos-generation";
              generalTooltipText = "NixOS Generation";
              textCommand = "readlink /nix/var/nix/profiles/system | cut -d- -f2";
              textIntervalMs = 3000;
            }
            {
              id = "Battery";
              displayMode = "graphic";
            }
            {
              id = "Volume";
            }
            {
              id = "Brightness";
            }
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
          ];
        };
      };
    };
}
