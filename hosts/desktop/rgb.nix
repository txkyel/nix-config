# Taken from https://nixos.wiki/wiki/OpenRGB#Turn_off_RGB
{
  pkgs,
  lib,
  ...
}:
let
  no-rgb = pkgs.writeScriptBin "no-rgb" ''
    #!/bin/sh
    NUM_DEVICES=$(${pkgs.openrgb}/bin/openrgb --noautoconnect --list-devices | grep -E '^[0-9]+: ' | wc -l)

    for i in $(seq 0 $(($NUM_DEVICES - 1))); do
      ${pkgs.openrgb}/bin/openrgb --noautoconnect --device $i --mode direct --color 000000
    done
  '';
in
{
  config = {
    services.udev.packages = [ pkgs.openrgb ];
    boot.kernelModules = [
      "i2c-dev"
      "i2c-piix4"
    ];
    hardware.i2c.enable = true;

    systemd.services.no-rgb = {
      description = "no-rgb";
      serviceConfig = {
        ExecStart = "${no-rgb}/bin/no-rgb";
        Type = "oneshot";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };

  services.hardware.openrgb.enable = true;
}
