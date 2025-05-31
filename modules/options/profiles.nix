{ config, lib, ... }:
let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
in
{
  options.profiles = {
    desktop.enable = mkEnableOption "Enable desktop profile";
    server.enable = mkEnableOption "Enable server profile";
    gaming = {
      enable = mkEnableOption "Enable gaming profile";
      enableVR = mkEnableOption "Enabling VR profile";
    };
  };

  config.assertions = mkIf config.profiles.gaming.enableVR [
    {
      assertion = config.profiles.gaming.enable;
      message = "The VR profile cannot be enabled if the gaming profile is not enabled";
    }
  ];
}
