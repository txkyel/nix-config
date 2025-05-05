{
  config,
  ...
}:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      animations = {
        bezier = [
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
        ];
        animation = [
          "fadeIn, 1, 2, md3_accel"
          "fadeOut, 1, 3, md3_decel"
        ];
      };

      general = {
        hide_cursor = false;
        grace = 1;
      };

      background = {
        path = "${config.xdg.cacheHome}/.current_wallpaper";
        blur_passes = 1;
      };

      input-field = {
        valign = "bottom";
        position = "0%, 10%";

        outline_thickness = 1;

        font_color = "rgb(b6c4ff)";
        outer_color = "rgba(180, 180, 180, 0.5)";
        inner_color = "rgba(200, 200, 200, 0.1)";
        check_color = "rgba(247, 193, 19, 0.5)";
        fail_color = "rgba(255, 106, 134, 0.5)";

        fade_on_empty = false;
        placeholder_text = "Enter Password";

        dots_spacing = 0.2;
        dots_center = true;

        shadow_color = "rgba(0, 0, 0, 0.1)";
        shadow_size = 7;
        shadow_passes = 2;
      };

      label = [
        {
          monitor = "";
          text = "$TIME";
          font_size = 150;
          color = "rgb(b6c4ff)";

          position = "0%, 30%";

          valign = "center";
          halign = "center";

          shadow_color = "rgba(0, 0, 0, 0.1)";
          shadow_size = 20;
          shadow_passes = 2;
          shadow_boost = 0.3;
        }
        {
          monitor = "";
          text = "cmd[update:3600000] date +'%a %b %d'";
          font_size = 20;
          color = "rgb(b6c4ff)";

          position = "0%, 40%";

          valign = "center";
          halign = "center";

          shadow_color = "rgba(0, 0, 0, 0.1)";
          shadow_size = 20;
          shadow_passes = 2;
          shadow_boost = 0.3;
        }
      ];
    };
  };
}
