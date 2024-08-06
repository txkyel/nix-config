{ pkgs, ... }:
{
    home.packages = with pkgs; [
        mangohud
    ];

    programs.mangohud = {
        enable = true;
        settings = {
            gpu_power = true;
            cpu_power = true;
        };
    };

    # Write config file to enable faster downloads and shader compilation
    xdg.dataFile."Steam/steam_dev.cfg".text = ''
        @nClientDownloadEnableHTTP2PlatformLinux 0
        @fDownloadRateImprovementToAddAnotherConnection 1.0
        @cMaxInitialDownloadSources 25
        unShaderBackgroundProcessingThreads 8
    '';
}
