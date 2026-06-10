{
  flake.aspects.niri.homeManager.programs.noctalia.settings = {
    calendar = {
      enabled = true;
      account.bazninethousand.type = "google";
    };

    location = {
      auto_locate = true;
    };

    shell = {
      avatar_path = "~/.face";
      clipboard_enabled = false;
      date_format = "{:%a %b %d}";
      niri_overview_type_to_launch_enabled = true;
      password_style = "random";
      time_format = "{:%H:%M:%S}";
    };

    theme = {
      builtin = "Catppuccin";
      source = "wallpaper";
    };

    wallpaper =
      let
        dir = ../../../assets/wallpapers;
        wallpaper = ../../../assets/wallpapers/doom_sasasu_interphos.png;
      in
      {
        directory = dir;
        default = {
          path = wallpaper;
        };
        last = {
          path = wallpaper;
        };
        monitors = {
          "DP-5" = {
            path = wallpaper;
          };
          "eDP-1" = {
            path = wallpaper;
          };
        };
      };

    weather = {
      unit = "imperial";
    };
  };

}
