{ config, ... }:
let
  # NVIDIA PRIME render-offload env vars (identical to the nvidia-offload wrapper).
  offloadEnv = {
    __NV_PRIME_RENDER_OFFLOAD = "1";
    __NV_PRIME_RENDER_OFFLOAD_PROVIDER = "NVIDIA-G0";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __VK_LAYER_NV_optimus = "NVIDIA_only";
  };
in
{
  flake.nixosConfigurations.metatron = config.flake.lib.make-host {
    system = "x86_64-linux";
    hostName = "metatron";
    userName = "bazinga";
    stateVersion = "24.05";
    aspects = [
      # General system configuration
      "niri"
      "flatpak"
      "fonts"
      "nix-alien"
      "theme"
      "zsa"

      # Package sets
      "creative"
      "games"
      "ghostty"
      "sajak"
      "social"
      "steam"
      "tools"
      # "vscode"
      "zen-browser"
      "zed"

      # Language tooling
      "polyglot"
    ];
  };

  flake.aspects.metatron = {
    description = ''
      Aspect for configurations specific to the metatron host.
    '';

    # manually include hardware conf
    nixos = {
      imports = [
        ../../hardware-configs/metatron.nix
        ../../hardware-configs/nvidia/metatron.nix
      ];

      # Enable thermald (for intel CPU)
      services.thermald.enable = true;

      nixpkgs.overlays = [
        (final: prev: let
          # Wrap a plain binary under the offload env. Preserves existing overrides.
          wrapOffloaded = name: base:
            let
              wrapper = prev.writeShellScriptBin name ''
                export __NV_PRIME_RENDER_OFFLOAD=1
                export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
                export __GLX_VENDOR_LIBRARY_NAME=nvidia
                export __VK_LAYER_NV_optimus=NVIDIA_only
                exec ${base}/bin/${name} "$@"
              '';
            in
            wrapper // {
              # Attach top-level `.override`/`.overrideAttrs`
              override = args: wrapOffloaded name (base.override args);
              overrideAttrs = f: wrapOffloaded name (base.overrideAttrs f);
            };
        in {
          # Override steam differently since it has extraEnv
          steam = prev.steam.override { extraEnv = offloadEnv; };

          prismlauncher = wrapOffloaded "prismlauncher" prev.prismlauncher;
          godot = wrapOffloaded "godot" prev.godot;
          obs-studio = wrapOffloaded "obs-studio" prev.obs-studio;
        })
      ];
    };

    homeManager = {
      # Force Zen onto NVIDIA via the module's supported `env` option
      programs.zen-browser.env = offloadEnv;
    };
  };
}
