{ pkgs, config, username, ... }:
let
    home = config.users.users.${username}.home;
    MangoHudConf = "${home}/.config/MangoHud/MangoHud.conf";
in
{
    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
    };
    environment.systemPackages = with pkgs; [
        steamtinkerlaunch
    ];
    programs.gamemode.enable = true;
    programs.gamescope = {
        enable = true;
        env = {
            MANGOHUD_CONFIGFILE = MangoHudConf;
        };
    };
}
