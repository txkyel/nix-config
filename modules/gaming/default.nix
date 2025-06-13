{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  inherit (lib.modules) mkIf mkMerge;
  cfg = config.profiles.gaming;

  MangoHudConf = "${config.users.users.${username}.home}/.config/MangoHud/MangoHud.conf";
in
{
  config = mkIf cfg.enable (mkMerge [
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

      # amdgpu for corectrl
      programs.corectrl = {
        enable = true;
        gpuOverclock.enable = true;
        gpuOverclock.ppfeaturemask = "0xffffffff";
      };

      environment.systemPackages = with pkgs; [
        protonup-qt
        steamtinkerlaunch # Additional mods and games
        owmods-gui # ??
      ];

      users.users.${username}.extraGroups = [
        "gamemode"
      ];

      # TODO: Figure out how to separate home manager stuff more elegantly
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
    }

    (mkIf cfg.enableVR {
      # VR
      programs.adb.enable = mkIf cfg.enableVR true;
      programs.envision = mkIf cfg.enableVR {
        enable = true;
      };

      environment.systemPackages = with pkgs; [
        wlx-overlay-s # VR overlay
        sidequest
        bs-manager
      ];

      users.users.${username}.extraGroups = [
        "adbusers"
      ];
    })
  ]);
}
