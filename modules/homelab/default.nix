{ lib, config, ... }:
let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) str;
  cfg = config.homelab;
in
{
  imports = [
    ./jellyfin.nix
  ];

  options.homelab = {
    enable = mkEnableOption "Enable homelab configs and services";
    user = mkOption {
      default = "share";
      type = str;
      description = "User running homelab services";
    };
    group = mkOption {
      default = "share";
      description = "Group to run homelb services";
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = config.profiles.enabled;
        message = "The server profile must be enabled if homelab enabled";
      }
    ];
    users = {
      groups.${cfg.group} = { };
      users.${cfg.user} = {
        isSystemUser = true;
        group = cfg.group;
      };
    };

    systemd.tmpfiles.rules = [
      "d /data/media 0770 - ${cfg.user} - -"
    ];
  };
}
