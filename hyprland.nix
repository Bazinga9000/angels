{pkgs, ...}: {
  # Hyprland
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$terminal" = "kitty";
    "$fileManager" = "thunar";
    "$browser" = "zen";
    "$editor" = "zeditor";

    bind = [
      # Program Launchers
      "$mod, Return, exec, $terminal"
      "$mod SHIFT, Return, exec, $browser"
      "$mod SHIFT, Q, killactive"
      "$mod, N, exec, $fileManager"
      "$mod, Space, exec, ${./config/rofi_executables/launcher}"
      "$mod, C, exec, $editor"
      "$mod SHIFT, C, exec, $editor ~/metatron"

      # Move the Focus
      "$mod, left, movefocus, l"
      "$mod, right, movefocus, r"
      "$mod, up, movefocus, u"
      "$mod, down, movefocus, d"

      # Floating and Fullscreen
      "$mod, F, togglefloating"
      "$mod SHIFT, F, fullscreen, 0" # Take entire screen
      "$mod CONTROL SHIFT, F, fullscreen, 0" # Preserve gaps/bars

      # Standard Workspaces
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"
      "$mod, 0, workspace, 10"

      "$mod SHIFT, 1, movetoworkspace, 1"
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod SHIFT, 4, movetoworkspace, 4"
      "$mod SHIFT, 5, movetoworkspace, 5"
      "$mod SHIFT, 6, movetoworkspace, 6"
      "$mod SHIFT, 7, movetoworkspace, 7"
      "$mod SHIFT, 8, movetoworkspace, 8"
      "$mod SHIFT, 9, movetoworkspace, 9"
      "$mod SHIFT, 0, movetoworkspace, 10"

      # Scratchpad Workspace
      # "$mod, S, togglespecialworkspace, magic"
      # "$mod SHIFT, S, movetoworkspace, special:magic"

      # Scroll through workspaces
      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"

      # Print Screen
      ", Print, exec, grimblast copy area"

      # Lock Screen / Rofi Powermenu
      "$mod, Escape, exec, hyprlock"
      "$mod SHIFT, Escape, exec, ${./config/rofi_executables/powermenu}"

      # Restart Waybar
      "$mod SHIFT, B, exec, pkill waybar && hyprctl dispatch exec waybar"

      # Leave
      "$mod SHIFT CONTROL, Escape, exit"
    ];

    bindm = [
      # Move/resize windows
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    exec-once = [
      "waybar &"         # Activate waybar for the status bar
      "nm-applet &"      # Network configuration in system tray
      "blueman-applet"   # Bluetooth
      "systemctl --user start hyprpolkitagent" # Auth
    ];

    env = [
      "XCURSOR_THEME, Numix-Cursor"
      "XCURSOR_SIZE, 24"
      "HYPRCURSOR_SIZE, 24"
    ];

    workspace = [
      "1, defaultName:α"
      "2, defaultName:β"
      "3, defaultName:γ"
      "4, defaultName:δ"
      "5, defaultName:ε"
      "6, defaultName:ζ"
      "7, defaultName:η"
      "8, defaultName:θ"
      "9, defaultName:ι"
      "10, defaultName:κ"
      # "special:magic, defaultName:⁂"
    ];

    general = {
      gaps_in = 5;
      gaps_out = 10;

      border_size = 2;

      "col.active_border" = "rgba(eba0acee) rgba(fab387ee) 45deg";
      "col.inactive_border" = "rgba(595959aa)";

      # Set to true to enable resizing windows by clicking and dragging on borders and gaps
      resize_on_border = false;

      # Check wiki before messing with this
      allow_tearing = false;

      layout = "dwindle";
    };

    decoration = {
      rounding = 10;

      active_opacity = 1.0;
      inactive_opacity = 1.0;

      blur = {
        enabled = true;
        size = 3;
        passes = 1;
        vibrancy = 0.1696;
      };

      shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
      };
    };

    # Disable the default wallpaper/splash
    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
    };

    # Quoth the default config, "You'll probably like this."
    windowrulev2 = [
      "suppressevent maximize, class:.*"
    ];

    monitor = [
      "eDP-1, 1920x1080, 0x0, 1"
      "DP-5, 1920x1080, 1920x0, 1"
    ];

    xwayland = {
      force_zero_scaling = true;
    };

    cursor = {
      no_hardware_cursors = true;
    };

    # Compose key
    input = {
      kb_options = "compose:caps";
    };
  };

  # Hyprlock
  programs.hyprlock.enable = true;
  # Since we're overriding default catppuccin, turn it off
  catppuccin.hyprlock.enable = false;
  programs.hyprlock.settings = {
    # Colors from catpuccin
    "$accent" = "rgb(cba6f7)"; # Mauve
    "$accentAlpha" = "cba6f7";
    "$base" = "rgb(1e1e2e)";
    "$surface0" = "rgb(313244)";
    "$text" = "rgb(cdd6f4)";
    "$textAlpha" = "cdd6f4";
    "$red" = "rgb(f38ba8)";
    "$yellow" = "rgb(f9e2af)";

    # Font
    "$font" = "Quicksand, M PLUS 1p";

    general = {
      disable_loading_bar = true;
      hide_cursor = true;
    };

    background = {
      monitor = "";
      path = "$HOME/.config/background";
      blur_passes = 0;
      color = "$base";
    };

    image = { # Profile picture
      monitor = "";
      path = "$HOME/.face";
      size = 100;
      border_color = "$accent";
      position = "0, 75";
      halign = "center";
      valign = "center";
    };

    # INPUT FIELD
    input-field = {
      monitor = "";
      size = "300, 60";
      outline_thickness = 4;
      dots_size = 0.2;
      dots_spacing = 0.2;
      dots_center = true;
      outer_color = "$accent";
      inner_color = "$surface0";
      font_color = "$text";
      font_family = "$font";
      fade_on_empty = false;
      placeholder_text = "<span foreground=\"##$textAlpha\"><i>󰌾 Logged in as </i><span foreground=\"##$accentAlpha\">$USER</span></span>";
      hide_input = false;
      check_color = "$accent";
      fail_color = "$red";
      fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
      capslock_color = "$yellow";
      position = "0, -47";
      halign = "center";
      valign = "center";
    };

    label = [
      { # Time
        monitor = "";
        text = "cmd[update:1000] echo \"$(date +\"%H:%M:%S\")\"";
        color = "$text";
        font_size = 90;
        font_family = "$font";
        position = "-30, 0";
        halign = "right";
        valign = "top";
      }
      { # Date
        monitor = "";
        text = "cmd[update:1000] date +\"%A, %d %B %Y\"";
        color = "$text";
        font_size = 25;
        font_family = "$font";
        position = "-30, -150";
        halign = "right";
        valign = "top";
      }
      { # Uptime
        monitor = "";
        text = "cmd[update:1000] nu ${./scripts/uptime.nu}";
        color = "$text";
        font_size = 25;
        font_family = "$font";
        position = "30, -30";
        halign = "left";
        valign = "top";
      }
    ];
  };

  # Hypridle
  services.hypridle.enable = true;
  services.hypridle.settings = {
    general = {
      after_sleep_cmd = "hyprctl dispatch dpms on";
      ignore_dbus_inhibit = false;
      lock_cmd = "hyprlock";
    };

    listener = [
      {
        timeout = 600;
        on-timeout = "hyprlock";
      }

      {
        timeout = 720;
        on-timeout = "hyprctl dispatch dpms off";
        on-resume = "hyprctl dispatch dpms on";
      }
    ];
  };

  # Hyprpaper
  services.hyprpaper.enable = true;
  services.hyprpaper.settings = let
    tinot_robots = ./config/wallpapers/tinot_robots_in_the_garden.png;
    xiv_interphos = ./config/wallpapers/doom_sasasu_interphos.png;
  in {
    preload = "${xiv_interphos}";
    wallpaper = ", ${xiv_interphos}";
  };
}
