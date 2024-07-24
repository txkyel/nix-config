{ pkgs, ... }:
{
    programs.dconf.enable = true;
    services = {
        dbus.enable = true;
        envfs.enable = true;
        fstrim.enable = true;
        fwupd.enable = true;
        gvfs.enable = true;
        udev.enable = true;
    };
}
