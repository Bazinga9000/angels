{ pkgs, nix-vscode-extensions, ...}: {

  # Basic configuration
  home.username = "bazinga";
  home.homeDirectory = "/home/bazinga";
  programs.home-manager.enable = true;
  home.stateVersion = "24.05"; # !!! Don't change this !!!

  # Packages
  home.packages = with pkgs; [
    vivaldi          # Browser
    polkit_gnome     # Authentication Agent
    grimblast        # Screenshot Tool
    gimp             # GNU Image Manipulation Program
    inkscape         # Vector Graphics
    cockatrice       # MTG Client
    yed              # Yed Graph Editor
    element-desktop  # Matrix Client
    font-manager     # Font Manager
    mathematica      # Mathematica (NB: Installer needs manual addition to nix-store)
    flatpak          # Flatpak
    graphviz         # Graph Visualization Tools
    zathura          # PDF Viewer
    bottles          # Running windows applications
    rofi-wayland     # Rofi Package
    just             # Command runner
    sm64coopdx       # Mario 64 Port
    baobab           # Disk Usage Analyzer
    qgis             # Geographic Information System
    celeste64        # Celeste 64 - Fragments of the Mountain

    # Zed Editor (libz is for the Discord presence extension)
    (zed-editor.fhsWithPackages (ps: with ps; [
     libz
     openssl
    ]))

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

    # Libreoffice and Spell Check
    libreoffice-qt
    hunspell
    hunspellDicts.en_US

    # GNOME Keyring
    gnome-keyring
    seahorse

    # Language - Haskell
    ghc
    stack
    haskellPackages.haskell-language-server

    # Language - PureScript
    purs
    spago-unstable
    purs-tidy-bin.purs-tidy-0_10_0
    purs-backend-es

    # Language - C, C++
    gcc
    libgcc

    # Language - Rust
    rustup

    # Language - Nix
    nil

    # Language - Lua
    lua
    love

    # Language - Python
    python313
    uv
  ];

  # Kitty
  programs.kitty.enable = true;
  programs.kitty.font = {
    name = "FantasqueSansM Nerd Font Mono";
    package = pkgs.nerd-fonts.fantasque-sans-mono;
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

  # Rofi
  xdg.configFile."rofi".source = ./config/rofi;

  # Nushell
  programs.nushell = {
    enable = true;
    configFile.source = ./config/nu/config.nu;
    shellAliases = {
      metatron = "just --justfile=/home/bazinga/metatron/justfile"; # Global command to interact with this config
    };
  };
}
