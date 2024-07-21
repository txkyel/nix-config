{ pkgs, ... }:
{
    programs.steam.enable = true;
    programs.gamemode.enable = true;

    hardware = {
        enableRedistributableFirmware = true;
        graphics = {
            enable = true;
            enable32Bit = true;
        };
    };
}
