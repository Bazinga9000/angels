{pkgs, lib, ...}: {
  programs.waybar = {
    enable = true;
    style = lib.mkForce ./config/waybar/style.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";

        modules-left = [
            "hyprland/workspaces"
            "hyprland/window"
        ];

        modules-center = [
            "clock"
        ];

        modules-right = [
            "custom/weather"
            "network"
            "custom/nixgen"
            "disk#root"
            "disk#home"
            "cpu"
            "memory"
            "pulseaudio"
            "battery"
            "tray"
        ];

        "hyprland/workspaces" = {
          format = "{name}\n{id}";
          justify = "center";
        };

        "hyprland/window" = {
            separate-outputs = true;
            format = "<big>{title}</big>";
            justify = "center";
        };

        tray = {
            icon-size = 21;
            spacing = 3;
        };

        clock = {
            timezone = "America/New York";
            interval = 1;
            tooltip-format = "<big>{:%B %Y}</big>\n<tt><small>{calendar}</small></tt>";
            format = "{:%b %d %Y\n%H:%M:%S}";
            justify = "center";
        };

        cpu = {
            interval = 1;
            format = " \n{usage}%";
            justify = "center";
        };

        "disk#root" = {
            interval = 5;
            format = " \n{free}";
            path = "/nix/store";
            justify = "center";
        };

        "disk#home" = {
            interval = 5;
            format = " \n{free}";
            path = "/home/";
            justify = "center";
        };

        battery = {
            states = {
            warning = 30;
            critical = 15;
            };

            format = "{icon}\n{capacity}%";
            format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            justify = "center";
        };

        memory = {
            interval = 1;
            format = " \n{used:0.1f}G";
            justify = "center";
        };

        "custom/nixgen" = {
            interval = 3;
            format = " \n{}";
            exec = "sh -c \"readlink /nix/var/nix/profiles/system | cut -d- -f2\"";
            justify = "center";
        };

        network = {
            interval = 3;
            format = "  {bandwidthDownBytes}\n  {bandwidthUpBytes}";
            tooltip-format = "{essid} - {ipaddr}";
            justify = "center";
        };

        pulseaudio = {
            # scroll-step = 1;
            format = "{icon}\n{volume}%";
            format-muted = "󰖁";
            format-icons = {
            default = ["󰕿" "󰖀" "󰕾"];
            };
            on-click = "${pkgs.pwvucontrol}/bin/pwvucontrol";
            justify = "center";
        };

        "custom/weather" = {
            format = "{}";
            tooltip = true;
            interval = 600;
            exec = "${pkgs.wttrbar}/bin/wttrbar --fahrenheit --mph --custom-indicator \"{ICON} \n{temp_F}°\"";
            return-type = "json";
            justify = "center";
        };
      };
    };
  };
}
