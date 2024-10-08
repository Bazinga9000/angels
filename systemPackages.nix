{ config, pkgs, ...}:
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

    # Developer Libraries
    pkg-config
    zlib zlib.dev zlib.out
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

  # Hint electron apps to use Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Hint steam games to use Wayland
  environment.sessionVariables.SDL_VIDEODRIVER = "wayland"; 
  
  # Enable Hyprlock in PAM
  security.pam.services.hyprlock = {};
  
  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    nerdfonts
    hermit
    google-fonts
  ];
}
