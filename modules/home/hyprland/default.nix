{ config, ... }:
let
    # TODO: figure out how to unhardcode this, and make it dynamically determine where
    # the project source is located
    configPath = /home/kyle/nix-config/modules/home/hyprland/hypr;
in
{
    xdg.configFile.hypr.source = config.lib.file.mkOutOfStoreSymlink configPath;
}
