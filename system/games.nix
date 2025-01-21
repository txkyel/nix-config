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
    systemd.user.services.monado.environment = {
        STEAMVR_LH_ENABLE = "1";
        XRT_COMPOSITOR_COMPUTE = "1";
    };
    programs.envision = {
        enable = false;
    };
    services.wivrn = {
        # Use wivrn in case envision breaks
        enable = true;
        openFirewall = true;
        defaultRuntime = true;
        autoStart = true;
        config.enable = true;
        config.json = {
            scale = 0.5;
            bitrate = 200000000;
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
}
