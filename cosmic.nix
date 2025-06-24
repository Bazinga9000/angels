{ pkgs, ... }: {
   services.displayManager.cosmic-greeter.enable = true;
   services.desktopManager.cosmic.enable = true;

   # Enable GNOME Keyring Services
   services.gnome.gnome-keyring.enable = true;
   security.pam.services.gdm.enableGnomeKeyring = true;
}
