{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;

  service = "sonarr";
  homelab = config.homelab;
  cfg = homelab.services.${service};
in
{
  options.homelab.services.${service} = {
    enable = mkEnableOption "Enable ${service}";
  };

  config = mkIf (homelab.enable && cfg.enable) {
    services.${service} = {
      enable = true;
      user = homelab.user;
      group = homelab.user;
    };

    services.blocky.settings.customDNS.mapping = {
      "${service}.lan" = "192.168.0.245";
    };
    services.nginx.virtualHosts."${service}.lan" = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:8989";
        proxyWebsockets = true;
      };
    };
  };
}
