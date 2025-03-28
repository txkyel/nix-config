{ pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 0;
      systemd-boot.enable = true;
    };

    # Silent Boot
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "vga=current"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "boot.shell_on_fail"
    ];
  };
}
