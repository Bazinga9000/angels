{...}: {
  # Wayland Fixes
  environment.sessionVariables.NIXOS_OZONE_WL = "1"; # Electron
  environment.sessionVariables.SDL_VIDEODRIVER = "wayland"; # Steam
}
