# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, lib, inputs, ... }:

{
  imports =
    [
      inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x230
      inputs.kmonad.nixosModules.default
      ./hardware-configuration.nix
      ./../common.nix # Remove after migration to modules is complete
      ./../../modules/core
    ];

  services.kmonad = {
    enable = true;
    keyboards = {
      laptop-keyboard = {
        device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
        config = builtins.readFile ./laptop.kbd;
      };
    };
  };

  programs.steam.enable = true;
  programs.gamemode.enable = true;
}
