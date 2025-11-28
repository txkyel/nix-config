{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;

  service = "qbittorrent";
  homelab = config.homelab;
  cfg = homelab.services.${service};
in
{
  options.homelab.services.${service} = {
    enable = mkEnableOption "Enable ${service}";
  };

  config = mkIf (homelab.enable && cfg.enable) {
    # Note: You'll have to open up service logs to find the password when first
    # accessing the WebUI
    services.qbittorrent = {
      enable = true;
      user = homelab.user;
      group = homelab.user;
      serverConfig = {
        LegalNotice.Accepted = true;
        Preferences.WebUI.LocalHostAuth = false;
        Preferences.WebUI.AuthSubnetWhitelistEnabled = true;
        Preferences.WebUI.AuthSubnetWhitelist = "192.168.0.0/24";
      };
    };
  };
}
