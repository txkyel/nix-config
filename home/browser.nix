{ pkgs, ... }:
let
  commandLineArgs = [
    "--enable-features=AllowWindowDragUsingSystemDragDrop"
  ];
in
{
  home.packages = with pkgs; [
    (google-chrome.override {
      commandLineArgs = commandLineArgs;
    })
  ];

  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "bdioigkngoclklbmmgegppmmekffpgdh"; }
    ];
    commandLineArgs = commandLineArgs;
  };
}
