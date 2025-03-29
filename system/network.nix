{
  pkgs,
  lib,
  host,
  ...
}:
{
  networking = {
    hostName = "${host}";
    networkmanager.enable = true;
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];

  # Allow system to boot before internet is connected
  systemd.services.NetworkManager-wait-online.wantedBy = lib.mkForce [ ];
}
