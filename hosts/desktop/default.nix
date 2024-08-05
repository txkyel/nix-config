# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, lib, inputs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../game.nix
    ];

    hardware.logitech.wireless.enable = true;
    hardware.logitech.wireless.enableGraphical = true;
}