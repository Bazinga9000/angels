{config, lib, ...}: {
  flake.nixosConfigurations.jophiel = config.flake.lib.make-host {
    system = "x86_64-linux";
    hostName = "jophiel";
    userName = "bazinga";
    stateVersion = "25.05";
    homeStateVersion = "25.11"; # This is different from stateVersion because jophiel didn't use HM before the great dendrification
    aspects = [
      "cosmic"
      "python"
    ];
  };

  flake.aspects.jophiel = {
    description = ''
      Aspect for configurations specific to the jophiel host
    '';

    # manually include hardware conf
    nixos = {
      imports = [
        ../../hardware-configs/jophiel.nix
      ];

      # Override grub setings for jophiel
      boot.loader.grub.device = lib.mkForce "/dev/sda";
      boot.loader.grub.efiSupport = lib.mkForce false;
      boot.loader.efi.canTouchEfiVariables = lib.mkForce false;
    };
  };
}
