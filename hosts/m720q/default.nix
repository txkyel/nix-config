{ pkgs, ... }:
{
  imports = [
    ./options.nix
    ./hardware-configuration.nix
  ];

  system.stateVersion = "25.05"; # Did you read the comment?
  services.openssh.enable = true;

  services.xserver.displayManager.gdm.autoSuspend = false;

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
