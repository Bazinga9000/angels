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
            "custom/gpu"
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
            # Dirty Hack: All of the rules that are subsets of other rules start with ".big>" instead of "<big>" so they appear first in the output.
            rewrite = {
              "<big>(.*) - Vivaldi</big>" = "<big>󰖟  $1</big>"; # Vivaldi (Default)
              ".big>(.*) - Youtube - Vivaldi</big>" = "<big>󰖟  󰗃  $1</big>"; # Vivaldi (Youtube)
              ".big>(.*) - Google Sheets - Vivaldi</big>" = "<big>󰖟  󰧷  $1</big>"; # Vivaldi (Google Sheets)
              ".big>(.*) - Google Docs - Vivaldi</big>" = "<big>󰖟  󰈙  $1</big>"; # Vivaldi (Google Docs)
              ".big>(.*) - Wikipedia - Vivaldi</big>" = "<big>󰖟  󰖬  $1</big>"; # Vivaldi (Wikipedia)

              "<big>(?:• |\\(\\d+\\) )?Discord \\| (.*) \\| (.*)</big>" = "<big>  $2  $1</big>"; # Discord (Channel)
              ".big>(?:• |\\(\\d+\\) )?Discord \\| (.*) \\| User Settings</big>" = "<big>    $1</big>"; # Discord (Settings)
              "<big>(?:• |\\(\\d+\\) )?Discord \\| @(.*)</big>" = "<big>    $1</big>"; # Discord (Individual DM)
              "<big>(?:• |\\(\\d+\\) )?Discord \\| ([^@].*)</big>" = "<big>    $1</big>"; # Discord (Group Chat)

              "<big>(.*)([mM]etatron)(.*)</big>" = "<big>$1<span foreground=\"#f9e2af\">$2</span>$3</big>"; # Generic "metatron"
            };
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
            exec = "nu ${./scripts/nixOSGeneration.nu}";
            return-type = "json";
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

        "custom/gpu" = {
            format = "󰕣\n{}%";
            tooltip = false;
            interval = 1;
            exec = "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits";
            justify = "center";
        };
      };
    };
  };
}
