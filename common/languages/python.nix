{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    python3
    python310
    python313
    uv
  ];

  environment.sessionVariables = {
    # uv - Don't automatically install python binaries
    UV_PYTHON_DOWNLOADS = "never";
  };
}
