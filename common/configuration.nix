{ config, pkgs, ... }:
{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable experimental features (for flakes)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Automatic nix store optimize
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "07:00" ];

  # Automatic garbage collection
  nix.gc = {
   automatic = true;
   dates = "weekly";
   options = "--delete-older-than 30d";
  };
}
