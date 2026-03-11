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
        programs.vesktop.vencord.settings.plugins = {
          AlwaysAnimate.enabled = true;
          CallTimer.enabled = true;
          ConsoleJanitor.enabled = true;
          CrashHandler.enabled = true;
          FixYoutubeEmbeds.enabled = true;
          RevealAllSpoilers.enabled = true;
          RoleColorEverywhere.enabled = true;
          ServerListIndicators.enabled = true;
          ShikiCodeblocks.enabled = true;
          TypingTweaks.enabled = true;
          Unindent.enabled = true;
          WebKeybinds.enabled = true;
          WebScreenShareFixes.enabled = true;
        };
      };
  };
}
