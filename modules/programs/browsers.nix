{
  config,
  lib,
  pkgs,
  ...
}:
let
  commandLineArgs = [
    "--enable-features=AllowWindowDragUsingSystemDragDrop"
  ];
in
{
  config = lib.mkIf (config.profiles.desktop.enable) {
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
