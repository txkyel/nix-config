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
    # TODO: convert config to hjem
    hm.services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pgrep hyprlock || ${hyprlock}";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "${niri} msg action power-on-monitors";
        };
        listener = [
          {
            timeout = 150;
            on-timeout = "${brightnessctl} -s set 10";
            on-resume = "${brightnessctl} -r";
          }
          {
            timeout = 300;
            on-timeout = "${pkgs.systemd}/bin/loginctl lock-session";
          }
          {
            timeout = 330;
            on-timeout = "${niri} msg action power-off-monitors";
            on-resume = "${niri} msg action power-on-monitors";
          }
          {
            timeout = 600;
            on-timeout = "${pkgs.systemd}/bin/systemctl suspend";
          }
        ];
      };
    };
  };
}
