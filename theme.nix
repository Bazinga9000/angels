{ pkgs, ...}: {
  # Non-GTK: Catppuccin
  catppuccin.enable = true;
  # Explicitly disable mako to avoid build failure until catp fixes this
  catppuccin.mako.enable = false;

  # dconf Dark Mode (for the internet etc)
  dconf.enable = true;
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "palenight";
      color-scheme = "prefer-dark";
    };
  };

  # GTK: Palenight
  # Icons: Papirus-Dark
  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "palenight";
      package = pkgs.palenight-theme;
    };

    cursorTheme = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme=1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme=1;
    };
  };

  home.sessionVariables.GTK_THEME = "palenight";
}
