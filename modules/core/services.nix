{ lib, config, ... }:
let
  inherit (lib.modules) mkIf mkDefault mkMerge;
in
{
  config = mkMerge [
    {
      # TODO: ensure these services are all required as core features
      services = {
        dbus.enable = true;
        envfs.enable = true; # For shebang execution
        fstrim.enable = true;
        avahi = {
          enable = true;
          nssmdns4 = true;
          # Disable publishing by default, let hosts decide
          publish.enable = mkDefault false;
        };
      };
    }
    (mkIf config.profiles.desktop.enable {
      programs.dconf.enable = true;
      services = {
        # Reduce journald disk usage for faster boot time
        journald.extraConfig = "SystemMaxUse=50M";
      };
    })
  ];
}
