{ pkgs, nix-vscode-extensions, ...}: {
  
  # Basic configuration
  home.username = "bazinga";
  home.homeDirectory = "/home/bazinga";
  programs.home-manager.enable = true;
  home.stateVersion = "24.05"; # !!! Don't change this !!!

  # Packages
  home.packages = with pkgs; [
    vivaldi          # Browser
    xfce.thunar      # File Manager
    polkit_gnome     # Authentication Agent
    grimblast        # Screenshot Tool
    piper            # Logitech Mouse Configurator
    gimp             # GNU Image Manipulation Program
    inkscape         # Vector Graphics
    cockatrice       # MTG Client
    yed              # Yed Graph Editor
    element-desktop  # Matrix Client
    font-manager     # Font Manager
    
    # Minecraft
    (prismlauncher.override {
      jdks = [
        temurin-bin-8
        temurin-bin-17
        temurin-bin-21
      ];
    })  

    # Libreoffice and Spell Check
    libreoffice-qt
    hunspell
    hunspellDicts.en_US    

    # Language - Haskell
    ghc
    stack
    haskellPackages.haskell-language-server
    
    # Language - PureScript
    purescript
    spago
    esbuild
    
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
  ];
 
  # Kitty
  programs.kitty.enable = true;
  programs.kitty.font = {
    name = "Hermit";
    package = pkgs.hermit;
  };

  # Hyprlock
  programs.hyprlock.enable = true;
  programs.hyprlock.settings = import ./hyprlock.nix;
  
  # Hypridle
  services.hypridle.enable = true;
  services.hypridle.settings = {
    general = {
      after_sleep_cmd = "hyprctl dispatch dpms on";
      ignore_dbus_inhibit = false;
      lock_cmd = "hyprlock";
    };

    listener = [
      {
        timeout = 600;
        on-timeout = "hyprlock";
      }

      {
        timeout = 720;
        on-timeout = "hyprctl dispatch dpms off";
        on-resume = "hyprctl dispatch dpms on";
      }
    ];
  };
  
  # Hyprpaper
  services.hyprpaper.enable = true;
  services.hyprpaper.settings = let
    tinot_robots = ./config/wallpapers/tinot_robots_in_the_garden.png;
  in {
    preload = "${tinot_robots}";
    wallpaper = ", ${tinot_robots}";
  };

  # AGS
  programs.ags = {
    enable = true;
    configDir = ./config/ags;
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };
  
  # Nushell
  programs.nushell = {
    enable = true; 
    configFile.source = ./config/nu/config.nu;
  };

  # VSCodium
  programs.vscode = {
    enable = true;
    # package = pkgs.vscodium;
    extensions = let
        m = nix-vscode-extensions.extensions.x86_64-linux.vscode-marketplace;
        o = nix-vscode-extensions.extensions.x86_64-linux.open-vsx;
    in [
        o.rust-lang.rust-analyzer
        o.formulahendry.auto-close-tag
        o.hookyqr.beautify
        o.formulahendry.code-runner
        o.naumovs.color-highlight
        o.icrawl.discord-vscode
        o.dbaeumer.vscode-eslint
        o.github.vscode-pull-request-github
        o.haskell.haskell
        o.justusadam.language-haskell
        o.ms-python.isort
        o.ms-toolsai.jupyter
        o.ms-toolsai.vscode-jupyter-cell-tags
        o.ms-toolsai.jupyter-keymap
        o.ms-toolsai.jupyter-renderers
        o.james-yu.latex-workshop
        o.sumneko.lua
        o.zaaack.markdown-editor
        o.ocamllabs.ocaml-platform
        o.garlicbreadcleric.pandoc-markdown-syntax
        o.esbenp.prettier-vscode
        o.nwolverson.ide-purescript
        o.nwolverson.language-purescript
        o.ms-python.python
        o.redhat.vscode-xml
        o.redhat.vscode-yaml
        o.jnoortheen.nix-ide
        o.mkhl.direnv
        o.arrterian.nix-env-selector
        o.catppuccin.catppuccin-vsc
        o.catppuccin.catppuccin-vsc-icons
        o.emattiza.vscode-purty
    ];
  };

  # Default Applications
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/mailto" = "vivaldi-stable.desktop";
      "TerminalEmulator" = "kitty.desktop";
    };
  };
}
