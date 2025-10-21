{ pkgs, bizhawk, ... }:
{

  home.packages = with pkgs; [
    balatro # Balatro
    baz9k.a-solitaire-mystery # Hempuli's 30 Solitaire Variants
    baz9k.cambridge # Cambridge Stacker
    baz9k.magicseteditor.all # MSE incl. non-Magic Templates
    baz9k.nsmb-mariovsluigi # NSMB Mario VS. Luigi reimplementation
    celeste64 # Celeste 64 - Fragments of the Mountain
    cockatrice # MTG Client
    godot # Godot Game Engine
    olympus # Celeste Mod Manager
    sm64coopdx # Mario 64 Port
    xivlauncher # Final Fantasy XIV

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

    # Minecraft
    (prismlauncher.override {
      jdks = [
        temurin-bin-8
        temurin-bin-17
        temurin-bin-21
      ];
    })
  ];
}
