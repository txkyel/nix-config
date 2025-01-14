{ pkgs, pkgs-envision, config, username, ... }:
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
    programs.gamemode.enable = true;
    programs.gamescope = {
        enable = true;
        env = {
            MANGOHUD_CONFIGFILE = MangoHudConf;
        };
    };
    environment.systemPackages = with pkgs; [
        steamtinkerlaunch  # Additional mods and games
        wlx-overlay-s  # VR overlay
        owmods-gui
    ];

    # VR
    programs.corectrl = {
        enable = true;
        gpuOverclock = {
            enable = true;
            ppfeaturemask = "0xffffffff";
        };
    };
    programs.envision = {
        enable = true;
        package = pkgs-envision.envision;
    };
}
