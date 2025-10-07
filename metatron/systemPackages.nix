{ pkgs, lib, ...}:
{
  environment.systemPackages = with pkgs; [
    comma                # nix-shell wrapper
    vesktop              # discord - in systemPackages to allow screenshare with audio
    killall              # killall
    nix-alien            # running Weird Binaries
 ];

  # programs.XXXXX.enable zone
  programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
  };

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
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
}
