{
  flake.aspects.ssh = {
    description = ''
      Configures SSH and adds authorized keys from ./keys.nix
    '';

    nixos = {
      services.openssh = {
        enable = true;
        settings = {
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
        };
      };
    };
  };
}
