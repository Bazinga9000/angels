{
  flake.aspects.cosmic = {
    description = ''
      Enable the COSMIC Desktop Environment
    '';

    nixos = {
      # Enable COSMIC Greeter and Desktop
      services.displayManager.cosmic-greeter.enable = true;
      services.desktopManager.cosmic.enable = true;

      # Enable GNOME Keyring Services
      services.gnome.gnome-keyring.enable = true;
      security.pam.services.gdm.enableGnomeKeyring = true;

      # Wayland Environment Fixes
      environment.sessionVariables.NIXOS_OZONE_WL = "1"; # Electron
      # This causes more trouble than its worth, I think.
      # environment.sessionVariables.SDL_VIDEODRIVER = "wayland"; # Steam
    };
  };
}
