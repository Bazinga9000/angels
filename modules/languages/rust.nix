{
  flake.aspects.rust = {
    description = ''
      Tools for Rust
    '';

    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        rustup
      ];
    };
  };
}
