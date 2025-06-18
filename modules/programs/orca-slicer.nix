{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib) mkIf;
in
{
  config = mkIf (config.profiles.desktop.enable) {
    hj.packages = with pkgs; [
      orca-slicer
    ];

    xdg.mime.defaultApplications = {
      "model/stl" = "OrcaSlicer.desktop";
      "model/3mf" = "OrcaSlicer.desktop";
    };
  };
}
