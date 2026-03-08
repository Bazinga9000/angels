{
  flake.aspects.niri.homeManager =
    { pkgs, ... }:
    {
      programs.noctalia-shell.settings = {
        general = {
          passwordChars = true; # Fun characters on lockscreen password
          lockScreenBlur = 1.0;
        };
        hooks = {
          enabled = true;
          wallpaperChange = "";
          darkModeChange = "";
          screenLock = "";
          screenUnlock = "";
          performanceModeEnabled = "";
          performanceModeDisabled = "";
          startup = "nu ${./scripts/startup_hook.nu}";
          session = "";
        };

        location = {
          useFahrenheit = true;
        };
      };
    };
}
