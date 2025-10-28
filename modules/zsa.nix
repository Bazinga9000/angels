{
  flake.aspects.zsa = {
    description = ''
      Enable support for ZSA keyboards (e.g Moonlander)
    '';

    nixos = {
      hardware.keyboard.zsa.enable = true;
    };
  };
}
