{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    python3
    python310
    python313
    uv
  ];
}
