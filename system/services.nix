{ lib, ... }:
{
  programs.dconf.enable = true;
  services = {
    dbus.enable = true;
    envfs.enable = true; # For shebang execution
    fstrim.enable = true;
    gvfs.enable = true;
    flatpak.enable = true;
    # Reduce journald disk usage for faster boot time
    journald.extraConfig = "SystemMaxUse=50M";
    avahi = {
      enable = true;
      nssmdns4 = true;
      # Disable publishing by default, let hosts decide
      publish.enable = lib.mkDefault false;
    };
  };
}
