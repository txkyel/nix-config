{ lib, ... }:
let
  inherit (lib.options) mkEnableOption;
in
{
  options = {
    profiles.desktop.enable = mkEnableOption "Desktop profile";
    profiles.server.enable = mkEnableOption "Server profile";
  };
}
