{
  flake.aspects.tools = {
    description = ''
      Tools and productivity programs
    '';

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          android-tools # ADB
          baobab # Disk Usage Analyzer
          bottles # Run windows applications
          font-manager # Show installed fonts
          hexyl # Hex dump
          popsicle # USB Flasher

          # Libreoffice and Spell Check
          libreoffice-qt-fresh
          hunspell
          hunspellDicts.en_US
        ];
      };
  };
}
