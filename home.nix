{ pkgs, bizhawk, ... }:
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
    cockatrice # MTG Client
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
    sm64coopdx # Mario 64 Port
    celeste64 # Celeste 64 - Fragments of the Mountain
    baz9k.magicseteditor.all # MSE incl. non-Magic Templates
    baz9k.cambridge # Cambridge Stacker
    godot # Godot Game Engine
    olympus # Celeste Mod Manager
    helio-workstation # Composition software
    baz9k.a-solitaire-mystery # Hempuli's 30 Solitaire Variants
    krita # Art Program
    baz9k.microwave # Microtonal Synth
    jugglinglab # Juggling

    # Zed Editor (libz is for the Discord presence extension)
    (zed-editor.fhsWithPackages (
      ps: with ps; [
        libz
        openssl
      ]
    ))

    # Minecraft
    (prismlauncher.override {
      jdks = [
        temurin-bin-8
        temurin-bin-17
        temurin-bin-21
      ];
    })

    # Final Fantasy XIV
    xivlauncher
    # (xivlauncher-rb.override {
    #  # TODO: get config.hardware.nvidia.package to work
    #  nvngxPath = "${pkgs.linuxPackages.nvidiaPackages.beta}/lib/nvidia/wine";
    # })

    # Archipelago Client
    (archipelago.override {
      extraPackages = with pkgs; [
        # NB: archipelago-minecraft exists, but it adds openjdk and not temurin,
        # and this is a more general solution in case other games need things
        temurin-bin-17 # Java 17 for Minecraft
      ];
    })
    # Bizhawk Emulator
    (import bizhawk {
      inherit system;
    }).emuhawk-latest-bin

    # Libreoffice and Spell Check
    libreoffice-qt
    hunspell
    hunspellDicts.en_US

    # GNOME Keyring
    gnome-keyring
    seahorse
  ];

  # Zen Browser
  programs.zen-browser.enable = true;

  # Ghostty
  programs.ghostty.enable = true;
  programs.ghostty.settings = {
    font-family = "FairfaxHD";
    font-size = 14;
  };

  # Dunst Notifications
  services.dunst.enable = true;
  services.dunst.settings = {
    global = {
      follow = "mouse";
      corner_radius = 3;
      font = "FantasqueSansM Nerd Font Mono 12";
    };
  };

  # Nushell
  programs.nushell = {
    enable = true;
    configFile.source = ./config/nu/config.nu;
    shellAliases = {
      metatron = "just --justfile=/home/bazinga/metatron/justfile"; # Global command to interact with this config
    };
  };
}
