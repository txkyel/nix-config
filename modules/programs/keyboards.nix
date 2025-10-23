{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib.modules) mkIf;
in
{
  config = mkIf config.profiles.desktop.enable {
    environment.systemPackages = with pkgs; [
      via
      vial
    ];

    hardware.keyboard.qmk.enable = true;

    services.keyd.enable = true;
    services.keyd.keyboards = {
      fc980c = {
        ids = [ "0853:0138:2eafde13" ];
        settings = {
          main = {
            "\\" = "backspace";
            backspace = "\\";
            capslock = "layer(control)";
            "capslock+leftcontrol" = "capslock";
          };
        };
      };
      fw13 = {
        ids = [ "0001:0001:09b4e68d" ];
        settings = {
          main = {
            "\\" = "backspace";
            backspace = "\\";
            capslock = "layer(control)";
            "capslock+leftcontrol" = "capslock";
          };
        };
      };
    };
  };
}
