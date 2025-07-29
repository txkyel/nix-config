{ lib, config, ... }:
let
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.options) mkEnableOption;
  homelab = config.homelab;
  cfg = homelab.services.blocky;
in
{
  options.homelab.services.blocky = {
    enable = mkEnableOption "Enable blocky and reverse proxy settings";
  };

  config = mkIf (homelab.enable && cfg.enable) (mkMerge [
    {
      networking.firewall = {
        allowedTCPPorts = [ 53 ];
        allowedUDPPorts = [ 53 ];
      };

      services.blocky.enable = true;
      services.blocky.settings = {
        upstreams.groups.default = [
          "1.1.1.1" # Cloudflare
          "1.0.0.1"
          "8.8.8.8" # Google
          "8.8.4.4"
          "208.67.222.222" # OpenDNS
          "208.67.220.220"
        ];
        blocking = {
          denylists = {
            ads = [ "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts" ];
          };
          clientGroupsBlock = {
            default = [ "ads" ];
          };
        };
      };
    }
    {
      # Reverse proxy settings
      networking.firewall = {
        allowedTCPPorts = [ 80 ];
      };
      # TODO: Make services configure reverse proxy and dns mapping
      # TODO: Use setting for host ip
      services.blocky.settings = {
        customDNS.mapping = {
          "m720q.lan" = "192.168.0.245"; # Because mDNS doesn't appear to work with blocky
          "jellyfin.lan" = "192.168.0.245";
          "qbittorrent.lan" = "192.168.0.245";
        };
      };
      services.nginx = {
        enable = true;
        recommendedProxySettings = true;

        virtualHosts = {
          "jellyfin.lan" = mkIf homelab.services.jellyfin.enable {
            locations."/" = {
              proxyPass = "http://192.168.0.245:8096";
              proxyWebsockets = true;
            };
          };
          "qbittorrent.lan" = mkIf homelab.services.qbittorrent.enable {
            locations."/" = {
              proxyPass = "http://192.168.0.245:8080";
              proxyWebsockets = true;
            };
          };
        };
      };
    }
  ]);
}
