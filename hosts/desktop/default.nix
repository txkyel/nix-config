# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, ... }:
{
    imports = [
        ./hardware-configuration.nix
        #./rgb.nix
    ];

    hardware.logitech.wireless.enable = true;
    hardware.logitech.wireless.enableGraphical = true;

    # Games
    # TODO: Make games into a module enablable by the host
    programs.steam.enable = true;

    # Graphics
    services.xserver.videoDrivers = [ "amdgpu" ];
    hardware = {
        enableRedistributableFirmware = true;
        graphics = {
            enable = true;
            enable32Bit = true;
        };
    };

    # Enable zenpower sensors
    boot.blacklistedKernelModules = [ "k10temp" ];
    boot.kernelModules = [ "zenpower" ];
    boot.extraModulePackages = [ config.boot.kernelPackages.zenpower ];
}
