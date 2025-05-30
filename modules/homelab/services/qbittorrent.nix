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
      default = "/var/lib/qBittorent";
      description = "The path passed to qBittorrent via --profile.";
    };

    openFirewall = mkEnableOption "Open ports in the firewal for the qBittorrent WebUI.";

    port = mkOption {
      type = port;
      default = 8081;
      description = "qBittorrent WebUI port.";
    };
  };

  config = mkIf (homelab.enable && cfg.enable) {
    #networking.firewall = mkIf cfg.openFirewall {
    #  allowedTCPPorts = [ cfg.port ];
    #};

    systemd = {
      tmpfiles.settings.qbittorrentDirs = {
        ${cfg.profileDir}."d" = {
          mode = "755";
          user = homelab.user;
          group = homelab.group;
        };
      };
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
