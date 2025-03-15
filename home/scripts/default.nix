{ pkgs, ... }:
let
  screenshot = pkgs.writeScriptBin "screenshot" (builtins.readFile ./screenshot.sh);
  workspace-qtile = pkgs.writeScriptBin "workspace-qtile" (builtins.readFile ./workspace-qtile.sh);
in
{
  home.packages = with pkgs; [
    screenshot
    workspace-qtile
  ];
}
