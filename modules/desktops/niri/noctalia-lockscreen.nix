{
  flake.aspects.niri.homeManager.programs.noctalia.settings = {
    lockscreen_widgets = {
      enabled = true;
      schema_version = 2;
      widget_order = [
        "lockscreen-login-box@DP-5"
        "lockscreen-login-box@eDP-1"
        "lockscreen-widget-0000000000000001"
        "lockscreen-widget-0000000000000003"
        "lockscreen-widget-0000000000000002"
        "lockscreen-widget-0000000000000004"
      ];

      grid = {
        cell_size = 16;
        major_interval = 4;
        visible = true;
      };

      widget = {
        "lockscreen-login-box@DP-5" = {
          box_height = 0.0;
          box_width = 0.0;
          cx = 960.0;
          cy = 588.0;
          output = "DP-5";
          rotation = 0.0;
          type = "login_box";
        };

        "lockscreen-login-box@eDP-1" = {
          box_height = 0.0;
          box_width = 0.0;
          cx = 960.0;
          cy = 957.0;
          output = "eDP-1";
          rotation = 0.0;
          type = "login_box";
        };

        "lockscreen-widget-0000000000000001" = {
          box_height = 240.0;
          box_width = 400.0;
          cx = 960.0;
          cy = 428.0;
          output = "DP-5";
          rotation = 0.0;
          type = "clock";
          settings = {
            clock_style = "digital";
            format = "{:%H:%M:%S}";
          };
        };

        "lockscreen-widget-0000000000000002" = {
          box_height = 0.0;
          box_width = 0.0;
          cx = 960.0;
          cy = 698.0;
          output = "DP-5";
          rotation = 0.0;
          type = "weather";
        };

        "lockscreen-widget-0000000000000003" = {
          box_height = 48.0;
          box_width = 208.0;
          cx = 960.0;
          cy = 492.0;
          output = "DP-5";
          rotation = 0.0;
          type = "clock";
          settings = {
            background = false;
            format = "{:%a, %b %d}";
          };
        };

        "lockscreen-widget-0000000000000004" = {
          box_height = 0.0;
          box_width = 0.0;
          cx = 960.0;
          cy = 860.0;
          output = "DP-5";
          rotation = 0.0;
          type = "sticker";
          settings = {
            background = false;
            image_path = ../../../assets/icons/face_circle.png;
            opacity = 1.0;
          };
        };
      };
    };
  };
}
