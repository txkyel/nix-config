# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../common.nix
    ];

  networking.hostName = "x230"; # Define your hostname.

  services.kmonad = {
    enable = true;
    keyboards = {
      laptop-keyboard = {
        device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
        config = builtins.readFile ./laptop.kbd;
      };
    };
  };

  # Force options to override hardware defaults. This is to enable steam despite incompatibility.
  hardware.opengl = {
    enable = lib.mkForce true;
    driSupport = lib.mkForce true;
    driSupport32Bit = lib.mkForce true;
  };

  programs.steam.enable = true;
  programs.gamemode.enable = true;
}
