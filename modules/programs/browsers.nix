{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.modules) mkIf;

  commandLineArgs = [
    "--enable-features=AllowWindowDragUsingSystemDragDrop"
  ];
in
{
  config = mkIf (config.profiles.desktop.enable) {
    hj.packages = with pkgs; [
      (google-chrome.override {
        commandLineArgs = commandLineArgs;
      })
      (brave.override {
        commandLineArgs = commandLineArgs;
      })
    ];
  };
}
