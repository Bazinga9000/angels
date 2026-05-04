{
  flake.aspects.fwupd = {
    description = ''
      Enable fwupd to update system firmware.
    '';

    nixos = {
      services.fwupd.enable = true;
    };
  };
}
