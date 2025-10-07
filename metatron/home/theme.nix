{ pkgs, ... }:
{
  # Non-GTK: Catppuccin
  catppuccin.enable = true;
  catppuccin.accent = "peach";

  # dconf Dark Mode (for the internet etc)
  dconf.enable = true;
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "palenight";
      color-scheme = "prefer-dark";
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "catppuccin-mocha-dark-cursors";
    size = 16;
    package = pkgs.catppuccin-cursors.mochaDark;
  };
}
