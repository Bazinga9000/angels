{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    gcc
    libgcc
  ];
}
