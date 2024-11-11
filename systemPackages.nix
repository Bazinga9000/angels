{ pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    vim
    wget
    git

    comma                # nix-shell wrapper
    vesktop              # discord - in systemPackages to allow screenshare with audio
    networkmanagerapplet # applet for managing networks
    nushell              # alternative to sh with many functional paradigms
    gh                   # github cli
    killall              # killall
    nix-alien            # running Weird Binaries
 ];

  # programs.XXXXX.enable zone
  programs.firefox.enable = true;
  programs.hyprland.enable = true;

  programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      protontricks.enable = true;
      extest.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      extraCompatPackages = with pkgs; [
          proton-ge-bin
      ];
  };

  programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
  };

  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];
  programs.file-roller.enable = true;

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
    nerdfonts
    google-fonts
    corefonts
  ];
}
