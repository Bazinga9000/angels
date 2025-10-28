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
        zathura # PDF viewer

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
    };
  };
}
