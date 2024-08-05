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
}
