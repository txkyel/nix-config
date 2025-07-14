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

  # TODO: Make write this file to store and reference by both gamescope and hj
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
      hardware.amdgpu.overdrive.enable = true;
      hardware.amdgpu.overdrive.ppfeaturemask = "0xffffffff";
      programs.corectrl = {
        enable = true;
      };

      environment.systemPackages = with pkgs; [
        protonup-qt
        steamtinkerlaunch # Additional mods and games
        owmods-gui
        r2modman
        mangohud
      ];

      users.users.${username}.extraGroups = [
        "gamemode"
      ];

      hj = {
        files = {
          ".config/MangoHud/MangoHud.conf".text = ''
            cpu_power
            cpu_temp
            gpu_core_clock
            gpu_mem_clock
            gpu_temp
            table_columns=5
            vram
          '';
          ".local/share/Steam/steam_dev.cfg".text = ''
            @nClientDownloadEnableHTTP2PlatformLinux 0
            @fDownloadRateImprovementToAddAnotherConnection 1.0
            @cMaxInitialDownloadSources 25
            unShaderBackgroundProcessingThreads 8
          '';
        };
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
