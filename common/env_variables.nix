{...}: {
  environment.sessionVariables = {
    # uv - Don't automatically install python binaries
    UV_PYTHON_DOWNLOADS = "never";
  };
}
