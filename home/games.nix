{ config, pkgs, ... }:
{
    home.packages = with pkgs; [
        mangohud
        r2modman
    ];

    programs.mangohud = {
        enable = true;
        settings = {
            gpu_power = true;
            gpu_temp = true;
            cpu_power = true;
            cpu_temp = true;
            table_columns = 5;
        };
    };

    # Write config file to enable faster downloads and shader compilation
    xdg.dataFile."Steam/steam_dev.cfg".text = ''
        @nClientDownloadEnableHTTP2PlatformLinux 0
        @fDownloadRateImprovementToAddAnotherConnection 1.0
        @cMaxInitialDownloadSources 25
        unShaderBackgroundProcessingThreads 8
    '';

    # VR
    xdg.configFile."openxr/1/active_runtime.json".source = "${pkgs.wivrn}/share/openxr/1/openxr_wivrn.json";
    xdg.configFile."openvr/openvrpaths.vrpath".text = ''
      {
        "config" :
        [
          "${config.xdg.dataHome}/Steam/config"
        ],
        "external_drivers" : null,
        "jsonid" : "vrpathreg",
        "log" :
        [
          "${config.xdg.dataHome}/Steam/logs"
        ],
        "runtime" :
        [
          "${pkgs.opencomposite}/lib/opencomposite"
        ],
        "version" : 1
      }
    '';
}
