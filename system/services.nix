{
    programs.dconf.enable = true;
    services = {
        dbus.enable = true;
        envfs.enable = true; # For shebang execution
        fstrim.enable = true;
        gvfs.enable = true;
        input-remapper.enable = true;
    };
}
