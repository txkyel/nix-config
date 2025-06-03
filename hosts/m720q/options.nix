{
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
      jellyfin.enable = true;
      qbittorrent.enable = true;
    };
  };
}
