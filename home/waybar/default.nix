{
  config,
  pkgs,
  ...
}: let
  configPath = "${config.home.homeDirectory}/nix-config/home/waybar/waybar";
in {
  xdg.configFile.waybar.source = config.lib.file.mkOutOfStoreSymlink configPath;

  home.packages = with pkgs; [
    waybar
  ];

  programs.waybar.enable = true;
}
