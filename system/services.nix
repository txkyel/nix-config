{ pkgs, ... }:
{
    programs.dconf.enable = true;
    services = {
        dbus.enable = true;
        fstrim.enable = true;
        gvfs.enable = true;
    };
}
