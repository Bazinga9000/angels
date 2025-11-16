{ config, ... }:
{
  flake.nixosConfigurations.metatron = config.flake.lib.make-host {
    system = "x86_64-linux";
    hostName = "metatron";
    userName = "bazinga";
    stateVersion = "24.05";
    aspects = [
      # General system configuration
      "cosmic"
      "flatpak"
      "fonts"
      "nix-alien"
      "theme"
      "zsa"

      # Package sets
      "creative"
      "games"
      "ghostty"
      "social"
      "steam"
      "tools"
      "vscode"
      "zen-browser"
      "zed"

      # Language tooling
      "c-cpp"
      "haskell"
      "latex"
      "lua"
      "mathematica"
      "nix"
      "nu"
      "purescript"
      "python"
      "rust"
      "uiua"
    ];
  };

  flake.aspects.metatron = {
    description = ''
      Aspect for configurations specific to the metatron host
    '';

    # manually include hardware conf
    nixos = {
      imports = [
        ../../hardware-configs/metatron.nix
        ../../hardware-configs/nvidia/metatron.nix
      ];
    };
  };
}
