{
  flake.aspects.tools = {
    description = ''
      Tools and productivity programs
    '';

    homeManager = {pkgs, ...}: {
      home.packages = with pkgs; [
        baobab # Disk Usage Analyzer
        bottles # Run windows applications
        font-manager # Show installed fonts
        popsicle # USB Flasher
        zathura # PDF viewer

        # Libreoffice and Spell Check
        libreoffice-qt-fresh
        hunspell
        hunspellDicts.en_US
      ];
    };
  };
}
