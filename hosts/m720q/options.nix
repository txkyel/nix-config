{
  profiles.server.enable = true;
  homelab = {
    enable = true;

    samba = {
      enable = true;
      shares = {
        Media = {
          "path" = "/data/media";
        };
      };
    };

    services = {
      blocky.enable = true;
      jellyfin.enable = true;
      qbittorrent.enable = true;
    };
  };
}
