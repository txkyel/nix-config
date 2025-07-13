{ lib, config, ... }:
let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
  homelab = config.homelab;
  cfg = homelab.services.blocky;
in
{
  options.homelab.services.blocky = {
    enable = mkEnableOption "Enable blocky";
  };

  config = mkIf (homelab.enable && cfg.enable) {
    networking = {
      firewall.allowedTCPPorts = [ 53 ];
      firewall.allowedUDPPorts = [ 53 ];
    };

    services.blocky.enable = true;
    services.blocky.settings = {
      upstreams.groups.default = [
        "1.1.1.1"
        "1.0.0.1"
      ];

      blocking = {
        blackLists = {
          ads = [ "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts" ];
        };
        clientGroupsBlock = {
          default = [ "ads" ];
        };
      };
    };
  };
}
