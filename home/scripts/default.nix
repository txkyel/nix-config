{ pkgs, ... }:
let
  airplane-mode = pkgs.writeScriptBin "airplane-mode" (builtins.readFile ./airplane-mode.sh);
  screenshot = pkgs.writeScriptBin "screenshot" (builtins.readFile ./screenshot.sh);
  workspace-qtile = pkgs.writeScriptBin "workspace-qtile" (builtins.readFile ./workspace-qtile.sh);
in
{
  home.packages = [
    airplane-mode
    screenshot
    workspace-qtile
  ];
}
