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
    hj = {
      packages = with pkgs; [
        waybar
      ];
      files = {
        ".config/waybar".source = ./config;
      };
    };
  };
}
