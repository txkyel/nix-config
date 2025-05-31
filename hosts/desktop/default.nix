#Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ inputs, username, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.gigabyte-b550
    inputs.nixos-hardware.nixosModules.common-cpu-amd-zenpower
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    ./hardware-configuration.nix
    ./options.nix
  ];

  system.stateVersion = "24.05";

  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      8080
      8081
    ];
    allowedUDPPorts = [
      8080
      8081
    ];
  };

  home-manager.users.${username}.wayland.windowManager.hyprland.settings.monitor = [
    "DP-3, 2560x1440@144, 1920x0, 1"
    "HDMI-A-1, 1920x1080, 0x0, 1"
  ];
}
