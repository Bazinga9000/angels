{...}: {
  # Defaults
  environment.sessionVariables = {
    EDITOR = "vim";
    BROWSER = "vivaldi";
    TERMINAL = "kitty";
    TERM = "kitty";
  };

  # Wayland Fixes
  environment.sessionVariables.NIXOS_OZONE_WL = "1"; # Electron
  environment.sessionVariables.SDL_VIDEODRIVER = "wayland"; # Steam
  environment.sessionVariables.GSK_RENDERER = "ngl"; # Fix to "Error 71" for apps like file-roller
}