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
          gum # Shell script util
          hexyl # Hex dump
          hyperfine # Benchmarking
          lazygit # Git TUI
          lazyjournal # Journalctl TUI
          lazyssh # SSH TUI
          moreutils # Additions to unix coreutils (vidir, ts, etc...)
          pik # Process killer TUI
          repgrep # Find and replace wrapper around ripgrep
          ripgrep # Regex search tool
          sttr # String transformation
          wget # Network downloader
        ];
      };

    homeManager = {
      programs.btop.enable = true; # System Monitor
      programs.helix.enable = true; # Helix text editor
      programs.zellij.enable = true; # Terminal Multiplexer

      # Shell aliases for the above programs:
      programs.nushell.shellAliases = {
        s = "lazyssh";
        ag = "rg";
        j = "lazyjournal";
        p = "gping";
      };
    };
  };
}
