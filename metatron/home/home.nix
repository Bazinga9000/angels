{ pkgs, ... }:
{

  # Basic configuration
  home.username = "bazinga";
  home.homeDirectory = "/home/bazinga";
  programs.home-manager.enable = true;
  home.stateVersion = "24.05"; # !!! Don't change this !!!

  # Packages
  home.packages = with pkgs; [
    gimp # GNU Image Manipulation Program
    inkscape # Vector Graphics
    yed # Yed Graph Editor
    element-desktop # Matrix Client
    font-manager # Font Manager
    mathematica # Mathematica (NB: Installer needs manual addition to nix-store)
    flatpak # Flatpak
    graphviz # Graph Visualization Tools
    zathura # PDF Viewer
    bottles # Running windows applications
    just # Command runner
    baobab # Disk Usage Analyzer
    qgis # Geographic Information System
    helio-workstation # Composition software
    krita # Art Program
    baz9k.microwave # Microtonal Synth
    jugglinglab # Juggling
    obs-studio # OBS for recording

    # Zed Editor (libz is for the Discord presence extension)
    (zed-editor.fhsWithPackages (
      ps: with ps; [
        libz
        openssl
      ]
    ))

    # Libreoffice and Spell Check
    libreoffice-qt-fresh
    hunspell
    hunspellDicts.en_US
  ];

  # Zen Browser
  programs.zen-browser.enable = true;

  # Ghostty
  programs.ghostty.enable = true;
  programs.ghostty.settings = {
    font-family = "FairfaxHD";
    font-size = 14;
  };
}
