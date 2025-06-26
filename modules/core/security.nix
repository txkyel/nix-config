{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib.modules) mkIf mkMerge;
in
{
  config = mkMerge [
    {
      security.polkit.enable = true;
    }
    (mkIf config.profiles.desktop.enable {
      security = {
        # pam.services.swaylock = {};
        polkit.extraConfig = ''
          polkit.addRule(function(action, subject) {
              if ((action.id == "org.corectrl.helper.init" ||
                   action.id == "org.corectrl.helperkiller.init") &&
                  subject.local == true &&
                  subject.active == true &&
                  subject.isInGroup("users")) {
                      return polkit.Result.YES;
              }
          });
        '';
      };
      services.gnome.gnome-keyring.enable = true;
      environment.systemPackages = with pkgs; [
        polkit_gnome
      ];
      systemd.user.services.polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    })
  ];
}
