{
  flake.aspects.networking = {
    description = ''
      Configures networking and DNS
    '';

    nixos = {
      # Enable networking
      networking.networkmanager.enable = true;
      networking.networkmanager.wifi.powersave = false;

      # Set DNS
      networking.nameservers = [ "1.1.1.1" "9.9.9.9" ];
      networking.networkmanager.dns = "none";
    };
  };
}
