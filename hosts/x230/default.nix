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
    ];

  programs.steam.enable = true;
  programs.gamemode.enable = true;

  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;

  hardware = {
      enableRedistributableFirmware = true;
      graphics = {
          enable = true;
          enable32Bit = true;
      };
  };

  powerManagement.enable = true;

  services = {
    kmonad = {
      enable = true;
      keyboards = {
        laptop-keyboard = {
          device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
          config = builtins.readFile ./laptop.kbd;
        };
      };
    };
    upower = {
      enable = true;
      percentageLow = 20;
      percentageCritical = 5;
      percentageAction = 2;
      criticalPowerAction = "PowerOff";
    };
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;

        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 50;
        START_CHARGE_THRESH_BAT0 = 40;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };
  };
}
