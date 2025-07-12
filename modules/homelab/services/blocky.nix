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
    networking.nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];

    services.blocky.enable = true;
    services.blocky.settings = {
      # https://github.com/truxnell/nix-config/blob/359ac88339b2749c14957a4a1e809b687c247dc5/nixos/modules/nixos/services/blocky/default.nix#L8
      # https://github.com/paepckehh/nixos/blob/550d2401f4674f239114a1720f8ab4d3b0c3e29c/server/dns/blocky-add-monitoring-prometheus.nix#L15
      upstreams.groups.default = [
        "1.1.1.1"
        "1.0.0.1"
      ];

      blocking = {
        blackLists.ads = [ "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts" ];
        clientGroupsBlock.default = [ "ads" ];
        loading.strategy = "fast";
      };

      caching = {
        prefetching = true;
      };
    };
  };
}
