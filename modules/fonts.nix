{
  flake.aspects = {aspects, ...}: {
    fonts = {
      includes = with aspects; [baz9k];

      nixos = {pkgs, lib, ...}: {
        fonts.packages = with pkgs; [
          noto-fonts
          noto-fonts-cjk-sans
          noto-fonts-color-emoji
          liberation_ttf
          fira-code
          fira-code-symbols
          mplus-outline-fonts.githubRelease
          dina-font
          proggyfonts
          google-fonts
          corefonts
          baz9k.kreative-kore-fonts
        ] ++ (builtins.filter lib.isDerivation (builtins.attrValues nerd-fonts));
      };
    };
  };
}
