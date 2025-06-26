{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib.modules) mkIf;
in
{
  networking = {
    networkmanager.enable = true;
  };

  environment.systemPackages = mkIf config.profiles.desktop.enable [
    pkgs.networkmanagerapplet
  ];

  # Allow system to boot before internet is connected
  systemd.services.NetworkManager-wait-online.wantedBy = lib.mkForce [ ];
}
