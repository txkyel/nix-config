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
    programs.niri.enable = true;
    environment.systemPackages = with pkgs; [ xwayland-satellite ];
    hj.files.".config/niri/config.kdl".source = ./config.kdl;
  };
}
