{ pkgs, ... }:
let
  airplane-mode = pkgs.writeScriptBin "airplane-mode" (builtins.readFile ./airplane-mode.sh);
  clip-menu = pkgs.writeScriptBin "clip-menu" (builtins.readFile ./clip-menu.sh);
  volume = pkgs.writeScriptBin "volume" (builtins.readFile ./volume.sh);
  wallpaper = pkgs.writeScriptBin "wallpaper" (builtins.readFile ./wallpaper.sh);
in
{
  home.packages = [
    airplane-mode
    clip-menu
    volume
    wallpaper
  ];
}
