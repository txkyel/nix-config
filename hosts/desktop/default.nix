# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ inputs, config, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.gigabyte-b550
    ./hardware-configuration.nix
    #./rgb.nix
  ];

  system.stateVersion = "24.05";

  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;

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

  modules.gaming.enable = true;
  modules.gaming.enableVR = true;
}
