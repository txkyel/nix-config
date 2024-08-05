{ pkgs, ... }:
{
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.timeout = 2;
    boot.kernelPackages = pkgs.linuxPackages_latest;

    boot.loader.grub.enable = true;
    boot.loader.grub.devices = [ "nodev" ]; # Allow Windows boot entry
    boot.loader.grub.useOSProber = true; # Allow Windows boot entry
    boot.loader.grub.efiSupport = true; # Allow Windows boot entry
    boot.loader.grub.configurationLimit = 10;
}
