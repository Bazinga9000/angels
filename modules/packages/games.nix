{inputs, ...}: {
  flake-file.inputs.bizhawk = {
    url = "github:TASEmulators/BizHawk";
    flake = false;
  };

  flake.aspects = {aspects, ...}: {
    games = {
      description = ''
        Games and other fun things
      '';
      includes = with aspects; [baz9k];

      # TODO: declaratively declare a-solitaire-mystery and sm64 files here

      homeManager = {pkgs, ...}: {
        home.packages = with pkgs; [
          archipelago # Archipelago multiworld randomizer client
          asciiquarium # Command line ASCII acquarium
          baz9k.a-solitaire-mystery # Hempuli's 30 Solitaire Variants
          baz9k.cambridge # Cambridge Stacker
          baz9k.magicseteditor.all # MSE incl. non-Magic Templates
          baz9k.nsmb-mariovsluigi # NSMB Mario VS. Luigi reimplementation
          cbonsai # Command line bonsai trees
          celeste64 # Celeste 64 - Fragments of the Mountain
          cockatrice # MTG Client
          godot # Godot Game Engine
          jugglinglab # Juggling Lab
          olympus # Celeste Mod Manager
          sm64coopdx # Mario 64 Port
          xivlauncher # Final Fantasy XIV

          # Bizhawk Emulator
          (import inputs.bizhawk {
            inherit system;
          }).emuhawk-latest-bin

          # Minecraft
          (prismlauncher.override {
            jdks = [
              temurin-bin-8
              temurin-bin-17
              temurin-bin-21
            ];
          })
        ];
      };
    };
  };
}
