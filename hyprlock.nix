{
  background = {
    path = "screenshot";
    blur_size = 5;
    blur_passes = 5;
    noise = 0.0117;
    contrast = 1.3000;
    brightness = 0.8000;
    vibrancy = 0.2100;
    vibrancy_darkness = 0.0;
  };

  input-field = {
    size = "250, 50";
    outline_thickness = 3;
    dots_size = 0.33; # Scale of input-field height, 0.2 - 0.8
    dots_spacing = 0.15; # Scale of dots' absolute size, 0.0 - 1.0
    dots_center = true;
    outer_color = "#fff8e7";
    inner_color = "#000000";
    font_color = "#fff8e7";
    placeholder_text = "<i>Password...</i>";
    hide_input = false;
    position = "0, 200";
    halign = "center";
    valign = "bottom";
    fade_on_empty = "false";
  };

  label = [
    {
      text = "cmd[update:1000] echo \"<b><big>$(date +\"%H:%M:%S\")</big></b>\"";
      color = "#fff8e7";
      font_size = 94;
      
      position = "0, 0";
      halign = "center";
      valign = "center";
    }
  ];
}
