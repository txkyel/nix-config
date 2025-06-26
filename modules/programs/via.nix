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
  config = mkIf config.profiles.desktop.enable {
    environment.systemPackages = with pkgs; [
      via
      vial
    ];

    hardware.keyboard.qmk.enable = true;
  };
}
