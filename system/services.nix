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
    udev.extraRules = ''
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="plugdev"
    '';
  };
}
