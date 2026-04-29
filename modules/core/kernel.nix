{
  flake.aspects.kernel = {
    description = ''
      Use the latest Linux kernel.
    '';

    nixos =
      { pkgs, ... }:
      {
        boot.kernelPackages = pkgs.linuxPackages_latest;
      };
  };
}
