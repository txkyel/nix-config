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
        sidequest
    ];

    # VR
    programs.adb.enable = true;
    programs.corectrl = {
        enable = true;
        gpuOverclock = {
            enable = true;
            ppfeaturemask = "0xffffffff";
        };
    };
    services.wivrn = {
        # Use wivrn in case envision breaks
        enable = false;
        openFirewall = true;
        defaultRuntime = true;
        autoStart = true;
        config.enable = true;
        config.json = {
            bitrate = 150000000;
            application = [ pkgs.wlx-overlay-s ];
            encoders = [
                {
                    encoder = "vaapi";
                    codec = "h265";
                    width = 0.5;
                    height = 0.25;
                    offset_x = 0.0;
                    offset_y = 0.0;
                    group = 0;
                }
                {
                    encoder = "vaapi";
                    codec = "h265";
                    width = 0.5;
                    height = 0.75;
                    offset_x = 0.0;
                    offset_y = 0.25;
                    group = 0;
                }
                {
                    encoder = "vaapi";
                    codec = "h265";
                    width = 0.5;
                    height = 1.0;
                    offset_x = 0.5;
                    offset_y = 0.0;
                    group = 0;
                }
            ];
        };
    };
    programs.envision = {
        enable = true;
        package = pkgs-envision.envision;
    };
}
