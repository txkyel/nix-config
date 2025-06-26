{
  lib,
  config,
  username,
  ...
}:
let
  inherit (lib.modules) mkIf;
in
{
  config = mkIf config.profiles.desktop.enable {
    programs.hyprlock.enable = true;

    hj.files = {
      ".config/hypr/hyprlock.conf".text = ''
        animations {
          animation = fade, 0
        }

        background {
          blur_passes = 1
          path = ${config.users.users.${username}.home}/.cache/.current_wallpaper
        }

        general {
          grace = 1
          hide_cursor = false
        }

        input-field {
          check_color = rgba(247, 193, 19, 0.5)
          dots_center = true
          dots_spacing = 0.200000
          fade_on_empty = false
          fail_color = rgba(255, 106, 134, 0.5)
          font_color = rgb(b6c4ff)
          inner_color = rgba(200, 200, 200, 0.1)
          outer_color = rgba(180, 180, 180, 0.5)
          outline_thickness = 1
          placeholder_text = Enter Password
          position = 0%, 10%
          shadow_color = rgba(0, 0, 0, 0.1)
          shadow_passes = 2
          shadow_size = 7
          valign = bottom
        }

        label {
          monitor =
          color = rgb(b6c4ff)
          font_size = 150
          halign = center
          position = 0%, 30%
          shadow_boost = 0.300000
          shadow_color = rgba(0, 0, 0, 0.1)
          shadow_passes = 2
          shadow_size = 20
          text = $TIME
          valign = center
        }

        label {
          monitor =
          color = rgb(b6c4ff)
          font_size = 20
          halign = center
          position = 0%, 40%
          shadow_boost = 0.300000
          shadow_color = rgba(0, 0, 0, 0.1)
          shadow_passes = 2
          shadow_size = 20
          text = cmd[update:3600000] date +'%a %b %d'
          valign = center
        }
      '';
    };
  };
}
