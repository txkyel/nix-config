{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.modules) mkIf;
  brightnessctl = lib.getExe pkgs.brightnessctl;
  hyprlock = lib.getExe config.programs.hyprlock.package;
  niri = lib.getExe config.programs.niri.package;
in
{
  config = mkIf config.profiles.desktop.enable {
    services.hypridle.enable = true;
    hj.files = {
      ".config/hypr/hypridle.conf".text = ''
        general {
          after_sleep_cmd = ${niri} msg action power-on-monitors
          before_sleep_cmd = ${pkgs.systemd}/bin/loginctl lock-session
          lock_cmd = pgrep hyprlock || ${hyprlock}
        }

        listener {
          on-timeout = ${brightnessctl} -s set 10
          on-resume = ${brightnessctl} -r
          timeout = 150
        }
        listener {
          timeout = 300
          on-timeout = ${pkgs.systemd}/bin/loginctl lock-session
        }
        listener {
          timeout = 330
          on-timeout = ${niri} msg action power-off-monitors
          on-resume = ${niri} msg action power-on-monitors
        }
        listener {
          timeout = 600
          on-timeout = ${pkgs.systemd}/bin/systemctl suspend
        }
      '';
    };
  };
}
