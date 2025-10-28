{
  flake.aspects.boot = {
    description = ''
      Configures the bootloader and boot filesystems.
    '';

    nixos = {
      # Bootloader.
      boot.loader.grub.enable = true;
      boot.loader.grub.device = "nodev";
      boot.loader.grub.useOSProber = true;
      boot.loader.grub.efiSupport = true;
      boot.loader.efi.canTouchEfiVariables = true;

      # Enable NTFS Support
      boot.supportedFilesystems = ["ntfs"];
    };
  };
}
