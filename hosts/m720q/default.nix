{ pkgs, ... }:
{
  imports = [
    ./options.nix
    ./hardware-configuration.nix
  ];

  system.stateVersion = "25.05";
  services.openssh.enable = true;

  # TODO: move into a server profile locked setting
  services.displayManager.gdm.autoSuspend = false;

  # Intel graphics for jellyfin
  boot.kernelParams = [ "i915.enable_guc=2" ];
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
    ];
  };
}
