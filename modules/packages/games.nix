{ inputs, ... }:
{
  flake-file.inputs.bizhawk = {
    url = "github:TASEmulators/BizHawk";
    flake = false;
  };

  flake-file.inputs.hytale-launcher = {
    url = "github:TNAZEP/HytaleLauncherFlake";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects =
    { aspects, ... }:
    {
      games = {
        description = ''
          Games and other fun things
        '';
        includes = with aspects; [ baz9k ];

        # TODO: declaratively declare a-solitaire-mystery and sm64 and balatro files here

        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              a-solitaire-mystery # Hempuli's 30 Solitaire Variants
              archipelago # Archipelago multiworld randomizer client
              asciiquarium # Command line ASCII acquarium
              cambridge # Cambridge Stacker
              cbonsai # Command line bonsai trees
              celeste64 # Celeste 64 - Fragments of the Mountain
              cockatrice # MTG Client
              deadlock-mod-manager # Deadlock Mod Manager
              godot # Godot Game Engine
              magicseteditor-all # MSE incl. non-Magic Templates
              nsmb-mariovsluigi # NSMB Mario VS. Luigi reimplementation
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

              # Balatro, wrapped for curl for some mods
              (balatro.overrideAttrs (oldAttrs: {
                buildInputs = oldAttrs.buildInputs or [ ] ++ [ curl ];
                postInstall = oldAttrs.postInstall or "" + ''
                  wrapProgram $out/bin/balatro \
                    --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [ curl ]}"
                '';
              }))

              # Hytale
              inputs.hytale-launcher.packages.${pkgs.system}.default
            ];
          };
      };
    };
}
