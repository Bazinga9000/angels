{
  flake.aspects.xserver = {
    description = ''
      Configure X11
    '';

    nixos = {
      # Enable X11
      services.xserver.enable = true;

      # Configure keymap in X11
      services.xserver.xkb = {
        layout = "us";
        variant = "";
      };
    };
  };
}
