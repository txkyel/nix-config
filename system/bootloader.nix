{ pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 0;
      systemd-boot.enable = true;
    };
    initrd.systemd.enable = true;

    tmp = {
      # Because tmpfs is disabled by default, I had undetected stale roots
      useTmpfs = true;
      tmpfsSize = "50%";
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
