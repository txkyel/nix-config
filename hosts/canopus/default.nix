#Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
    ./hardware-configuration.nix
    ./options.nix
  ];

  system.stateVersion = "25.05";

  services.fwupd.enable = true;

  services.keyd.enable = true;
  services.keyd.keyboards = {
    laptop = {
      ids = [ "0001:0001:70533846" ];
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
}
