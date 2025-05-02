{
  programs.niri.settings = {
    prefer-no-csd = true;

    layout = {
      gaps = 8;
      # struts = {
      #   left = 64;
      #   right = 64;
      #   top = 64;
      #   bottom = 64;
      # };

      default-column-width.proportion = 0.5;
      preset-column-widths = [
        { proportion = 0.25; }
        { proportion = 0.5; }
        { proportion = 0.75; }
      ];
      preset-window-heights = [
        { proportion = 0.25; }
        { proportion = 0.5; }
        { proportion = 0.75; }
      ];

      focus-ring = {
        width = 2;
        active.color = "#7fc8ff";
        inactive.color = "#505050";
      };
      border = {
        enable = false;
      };
      # TODO: Figure out if i want to keep or delete
      shadow = {
        enable = false;
        softness = 30;
        spread = 5;
        offset = {
          x = 0;
          y = 5;
        };
        color = "#0007";
      };
    };

    animations = {
      window-open.easing = {
        duration-ms = 200;
        curve = "linear";
      };
      window-close.easing = {
        duration-ms = 175;
        curve = "linear";
      };
      shaders = {
        window-open = ''
          vec4 expanding_circle(vec3 coords_geo, vec3 size_geo) {
            vec3 coords_tex = niri_geo_to_tex * coords_geo;
            vec4 color = texture2D(niri_tex, coords_tex.st);
            vec2 coords = (coords_geo.xy - vec2(0.5, 0.5)) * size_geo.xy * 2.0;
            coords = coords / length(size_geo.xy);
            float p = niri_clamped_progress;
            if (p * p <= dot(coords, coords))
            color = vec4(0.0);

            return color;
          }

          vec4 open_color(vec3 coords_geo, vec3 size_geo) {
            return expanding_circle(coords_geo, size_geo);
          }
        '';
        window-close = ''
          vec4 shrinking_circle(vec3 coords_geo, vec3 size_geo) {
            vec3 coords_tex = niri_geo_to_tex * coords_geo;
            vec4 color = texture2D(niri_tex, coords_tex.st);
            // Calculate coordinates relative to center, scaled appropriately
            vec2 coords = (coords_geo.xy - vec2(0.5, 0.5)) * size_geo.xy * 2.0;
            // Normalize coordinates based on diagonal length for a circular shape
            coords = coords / length(size_geo.xy);

            // Invert the progress for closing effect: 1 -> 0
            float p_close = 1.0 - niri_clamped_progress;
            
            // If pixel's squared distance from center is >= shrinking radius squared, make transparent
            // (Keeps pixels *inside* the shrinking radius p_close)
            if (p_close * p_close <= dot(coords, coords))
            color = vec4(0.0);

            // Optional: You could also fade the alpha slightly faster at the end if desired
            // color.a *= p_close; // Fades out completely as radius reaches 0

            return color;
          }

          vec4 close_color(vec3 coords_geo, vec3 size_geo) {
            return shrinking_circle(coords_geo, size_geo);
          }
        '';
      };
    };
  };
}
