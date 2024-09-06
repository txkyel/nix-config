{ pkgs, ... }:
{
    programs.dconf.enable = true;
    services = {
        dbus.enable = true;
        envfs.enable = true; # For shebang execution
        fstrim.enable = true;
        gvfs.enable = true;
        printing.enable = true;
        printing.drivers = with pkgs; [
            gutenprint
            samsung-unified-linux-driver
            splix
        ];
    };
}
