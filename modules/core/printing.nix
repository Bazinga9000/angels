{
  flake.aspects.printing = {
    description = ''
      Enable CUPS to print documents.
    '';

    nixos = {
      services.printing.enable = true;
    };
  };
}
