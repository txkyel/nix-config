{ pkgs, ... }:
let
  airplane-mode = pkgs.writeScriptBin "airplane-mode" (builtins.readFile ./airplane-mode.sh);
  clip-menu = pkgs.writeScriptBin "clip-menu" (builtins.readFile ./clip-menu.sh);
  screenshot = pkgs.writeScriptBin "screenshot" (builtins.readFile ./screenshot.sh);
  volume = pkgs.writeScriptBin "volume" (builtins.readFile ./volume.sh);
  wallpaper = pkgs.writeScriptBin "wallpaper" (builtins.readFile ./wallpaper.sh);
  workspace-qtile = pkgs.writeScriptBin "workspace-qtile" (builtins.readFile ./workspace-qtile.sh);
in
{
  home.packages = [
    airplane-mode
    clip-menu
    screenshot
    volume
    wallpaper
    workspace-qtile
  ];
}
