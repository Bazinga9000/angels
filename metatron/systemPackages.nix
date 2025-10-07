{ pkgs, lib, ...}:
{
  environment.systemPackages = with pkgs; [
    comma                # nix-shell wrapper
    vesktop              # discord - in systemPackages to allow screenshare with audio
    killall              # killall
    nix-alien            # running Weird Binaries
 ];
}
