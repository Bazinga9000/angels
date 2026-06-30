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
        # https://github.com/NixOS/nixpkgs/issues/536623
        programs.vesktop.package = pkgs.vesktop.override {
          pnpm_10_29_2 = pkgs.pnpm_10;
        };
        programs.vesktop.vencord.settings.plugins = {
          AlwaysAnimate.enabled = true;
          CallTimer.enabled = true;
          ConsoleJanitor.enabled = true;
          CrashHandler.enabled = true;
          FixYoutubeEmbeds.enabled = true;
          RevealAllSpoilers.enabled = true;
          RoleColorEverywhere.enabled = true;
          ServerListIndicators.enabled = true;
          ShikiCodeblocks = {
            enabled = true;
            tryHljs = "PRIMARY";
            useDevIcon = "COLOR";
          };
          TypingTweaks.enabled = true;
          Unindent.enabled = true;
          WebKeybinds.enabled = true;
          WebScreenShareFixes.enabled = true;
        };
      };
  };
}
