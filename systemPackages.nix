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

      # workaround for https://github.com/NixOS/nixpkgs/issues/353405
      package = pkgs.steam.override {
        extraLibraries = pkgs: [ pkgs.xorg.libxcb ];
        extraPkgs =
          pkgs: with pkgs; [
            attr
            xorg.libXcursor
            xorg.libXi
            xorg.libXinerama
            xorg.libXScrnSaver
            libpng
            libpulseaudio
            libvorbis
            stdenv.cc.cc.lib
            libkrb5
            keyutils
            gamemode
          ];
      };
      # end workaround 
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

  # Wayland Fixes
  environment.sessionVariables.NIXOS_OZONE_WL = "1"; # Electron
  environment.sessionVariables.SDL_VIDEODRIVER = "wayland"; # Steam
  environment.sessionVariables.GSK_RENDERER = "ngl"; # Fix to "Error 71" for apps like file-roller
  
  # Enable Hyprlock in PAM
  security.pam.services.hyprlock = {};
  
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
