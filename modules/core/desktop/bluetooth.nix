{ lib, config, ... }:
let
  inherit (lib.modules) mkIf;
in
{
  config = mkIf config.profiles.desktop.enable {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;
  };
}
