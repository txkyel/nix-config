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

    kernelParams = [
      "nowatchdog"
      "mitigations=off" # Open to CPU vulnerabilities
      "8250.nr_uarts=0" # Disable probing for old serial ports
    ];
  };
}
