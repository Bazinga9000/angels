{
  flake.aspects.cli = {
    description = ''
      Useful cross-host command-line tools
    '';

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          ast-grep # Syntax tree grep
          bat # Fancy cat
          gping # Graphical ping util
          hexyl # Hex dump
          hyperfine # Benchmarking
          lazygit # Git TUI
          ripgrep # Regex search tool
          wget # Network downloader
        ];
      };

    homeManager = {
      programs.btop.enable = true; # System Monitor
      programs.helix.enable = true; # Helix text editor
      programs.zellij.enable = true; # Terminal Multiplexer
    };
  };
}
