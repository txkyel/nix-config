{
  config,
  lib,
  pkgs,
  username,
  ...
}: let
  inherit (lib) mkIf mkEnableOption optionals;
  cfg = config.modules.gaming;

  MangoHudConf = "${config.users.users.${username}.home}/.config/MangoHud/MangoHud.conf";
in {
  options.modules.gaming = {
    enable = mkEnableOption "The default gaming profile";
    enableVR = mkEnableOption "Enabling VR";
  };

  config = mkIf cfg.enable {
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
    programs.corectrl = {
      enable = true;
      gpuOverclock = {
        enable = true;
        ppfeaturemask = "0xffffffff";
      };
    };

    environment.systemPackages = with pkgs;
      [
        protonup-qt
        steamtinkerlaunch # Additional mods and games
        owmods-gui # ??
      ]
      ++ optionals (cfg.enableVR) [
        wlx-overlay-s # VR overlay
        sidequest
      ];

    users.users.${username}.extraGroups =
      [
        "gamemode"
      ]
      ++ optionals (cfg.enableVR) [
        "adbusers"
      ];

    home-manager.users.${username} = {
      home.packages = with pkgs; [
        r2modman
      ];

      programs.mangohud.enable = true;
      programs.mangohud.settings = {
        gpu_core_clock = true;
        gpu_mem_clock = true;
        gpu_power = true;
        gpu_temp = true;
        vram = true;
        cpu_power = true;
        cpu_temp = true;
        table_columns = 5;
      };

      xdg.dataFile."Steam/steam_dev.cfg".text = ''
        @nClientDownloadEnableHTTP2PlatformLinux 0
        @fDownloadRateImprovementToAddAnotherConnection 1.0
        @cMaxInitialDownloadSources 25
        unShaderBackgroundProcessingThreads 8
      '';
    };

    # VR
    programs.adb.enable = mkIf cfg.enableVR true;
    programs.envision = mkIf cfg.enableVR {
      enable = true;
    };
  };
}
