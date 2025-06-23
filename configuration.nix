# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "metatron"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable NTFS Support
  boot.supportedFilesystems = ["ntfs"];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;

  # Set DNS
  networking.nameservers = [ "1.1.1.1" "9.9.9.9" ];
  networking.networkmanager.dns = "none";

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable support for ZSA keyboards
  hardware.keyboard.zsa.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true; # Enable bluetooth
  hardware.bluetooth.powerOnBoot = true; # Start default controller on boot
  services.blueman.enable = true; # Bluetooth GUI

  # File Manager Goodies (Trash, Thumbnails for images, etd)
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  # Upower (Battery Management)
  services.upower.enable = true;

  # Global Flatpak
  services.flatpak.enable = true;

  # Automatic nix store optimize
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "07:00" ];

  # Enable automatic garbage collection
  # [commented out for now because it appears to be killing hyprlock]
  # nix.gc = {
  #  automatic = true;
  #  dates = "weekly";
  #  options = "--delete-older-than 30d";
  # };

  # Enable polkit for authentication agents
  security.polkit.enable = true;

  # Enable Hyprlock in PAM
  security.pam.services.hyprlock = {};

  # Enable GNOME Keyring Services
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;


  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Set nushell to be the default shell
  users.defaultUserShell = pkgs.nushell;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bazinga = {
    isNormalUser = true;
    description = "bazinga";
    extraGroups = [ "networkmanager" "wheel" ];
    useDefaultShell = true;
    packages = [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable experimental features (for flakes)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
