{ pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 1;

  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ]; # Allow Windows boot entry
  boot.loader.grub.useOSProber = true; # Allow Windows boot entry
  boot.loader.grub.efiSupport = true; # Allow Windows boot entry
  boot.loader.grub.configurationLimit = 10;
  boot.loader.grub.extraEntries = ''
    menuentry "UEFI Firmware Settings" {
        fwsetup
    }
  '';

  # Silent Boot
  boot.kernelParams = [
    "quiet"
    "splash"
    "vga=current"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
  ];
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
}
