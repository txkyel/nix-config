{ pkgs, ... }:
let
  airplane-mode = pkgs.writeScriptBin "airplane-mode" (builtins.readFile ./airplane-mode.sh);
  screenshot = pkgs.writeScriptBin "screenshot" (builtins.readFile ./screenshot.sh);
  volume = pkgs.writeScriptBin "volume" (builtins.readFile ./volume.sh);
  workspace-qtile = pkgs.writeScriptBin "workspace-qtile" (builtins.readFile ./workspace-qtile.sh);
in
{
  home.packages = [
    airplane-mode
    screenshot
    volume
    workspace-qtile
  ];
}
