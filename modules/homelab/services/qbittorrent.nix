# NOTE copies bits and pieces from https://github.com/NixOS/nixpkgs/pull/287923
# Migrate to using this service config once it's been merged
{
  config,
  lib,
  pkgs,
  utils,
  ...
}:
let
  inherit (builtins) toString;
  inherit (lib)
    mkEnableOption
    mkOption
    mkPackageOption
    mkIf
    getExe
    ;
  inherit (lib.types) path port;
  service = "qbittorrent";
  homelab = config.homelab;
  cfg = homelab.services.${service};
in
{
  options.homelab.services.${service} = {
    enable = mkEnableOption "Enable ${service}";

    package = mkPackageOption pkgs "qbittorrent-nox" { };

    profileDir = mkOption {
      type = path;
      default = "/var/lib/qBittorrent";
      description = "The path passed to qBittorrent via --profile.";
    };

    port = mkOption {
      type = port;
      default = 8080;
      description = "qBittorrent WebUI port.";
    };
  };

  config = mkIf (homelab.enable && cfg.enable) {
    networking.firewall.allowedTCPPorts = [ cfg.port ];

    systemd = {
      tmpfiles.rules = [
        "d /var/lib/qBittorrent ${homelab.user} ${homelab.group} - -"
      ];

      services.qbittorrent = {
        description = "qBittorrent-nox service";
        documentation = [ "man:qbittorrent-nox(1)" ];
        wants = [ "network-online.target" ];
        after = [
          "local-fs.target"
          "network-online.target"
          "nss-lookup.target"
        ];
        wantedBy = [ "multi-user.target" ];

        serviceConfig = {
          Type = "simple";
          User = homelab.user;
          Group = homelab.group;

          ExecStart = utils.escapeSystemdExecArgs [
            (getExe cfg.package)
            "--profile=${cfg.profileDir}"
            "--webui-port=${toString cfg.port}"
          ];
          TimeoutStopSec = 1800;
          PrivateTmp = false;
        };
      };
    };
  };
}
