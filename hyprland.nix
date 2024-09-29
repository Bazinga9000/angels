{pkgs, ...}: {
  # Hyprland
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$terminal" = "kitty";
    "$fileManager" = "thunar";
    "$browser" = "vivaldi";
  
    bind = [
      # Program Launchers
      "$mod, Return, exec, $terminal"
      "$mod SHIFT, Return, exec, $browser"
      "$mod SHIFT, Q, killactive"
      "$mod, N, exec, $fileManager"
      "$mod, Space, exec, ags -t applauncher"
      "$mod SHIFT, C, exec, code ~/metatron --disable-gpu"
      
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
      "$mod, S, togglespecialworkspace, magic"
      "$mod SHIFT, S, movetoworkspace, special:magic"
  
      # Scroll through workspaces
      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"
    
      # Print Screen
      ", Print, exec, grimblast copy area"
      
      # Lock Screen
      "$mod, Escape, exec, hyprlock"
      
      # Reset AGS (In case bars dissapear from a monitor)
      "$mod SHIFT, B, exec, ags -q && ags &"

      # Leave
      "$mod SHIFT CONTROL, Escape, exit" 
    ];
    
    bindm = [
      # Move/resize windows
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
  
    exec-once = [
      "ags &"     # Enable AGS, activating status bar, app launcher, etc
      "nm-applet" # Network configuration in system tray
      "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &" # Auth
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
      "special:magic, defaultName:⁂"
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
  
      drop_shadow = true;
      shadow_range = 4;
      shadow_render_power = 3;
      "col.shadow" = "rgba(1a1a1aee)";
      
      blur = {
        enabled = true;
        size = 3;
        passes = 1;
        vibrancy = 0.1696;
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
  };
}