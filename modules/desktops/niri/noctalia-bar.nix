{
  flake.aspects.niri.homeManager.programs.noctalia.settings = {
    bar = {
      widgets = {
        center = [
          "clock"
          "date"
        ];
        contact_shadow = true;
        end = [
          "media"
          "tray"
          "notifications"
          "network"
          "volume"
          "brightness"
          "battery"
          "control-center"
        ];
        font_weight = 1000;
        margin_ends = 50;
        start = [
          "workspaces"
          "group:g1"
          "active_window"
        ];

        capsule_group = [
          {
            fill = "surface_variant";
            id = "g1";
            members = [
              "cpu"
              "temp"
              "ram"
              "network_rx"
              "network_tx"
              "sysmon"
            ];
            opacity = 1.0;
            padding = 6.0;
          }
          {
            fill = "surface_variant";
            id = "g2";
            members = [
              "tray"
              "media"
            ];
            opacity = 1.0;
            padding = 6.0;
          }
        ];
      };
    };

    widget = {
      active_window = {
        max_length = 300;
        title_scroll = "on_hover";
      };
      clock = {
        format = "{:%H:%M:%S}";
      };
      "control-center" = {
        glyph = "math-avg";
      };
      cpu = {
        display = "text";
      };
      date = {
        format = "{:%a %b %d}";
      };
      media = {
        title_scroll = "always";
      };
      network = {
        show_label = false;
      };
      network_rx = {
        display = "text";
      };
      network_tx = {
        display = "text";
      };
      nix_generation = {
        glyph = "brand-snowflake";
        type = "custom_button";
      };
      ram = {
        display = "text";
      };
      sysmon = {
        display = "text";
        path = "/home";
        stat = "disk_pct";
      };
      temp = {
        display = "text";
      };
    };
  };
}
