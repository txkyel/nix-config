{
  lib,
  config,
  ...
}:
let
  inherit (lib.modules) mkIf;
in
{
  config = mkIf config.profiles.desktop.enable {
    programs.waybar.enable = true;

    hj.files.".config/waybar".source = ./config;
  };
}
