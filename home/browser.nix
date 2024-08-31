{ pkgs, ... }:
{
    home.packages = with pkgs; [ google-chrome ];

    programs.chromium = {
        enable = true;
        package = pkgs.brave;
        extensions = [
            { id = "bdioigkngoclklbmmgegppmmekffpgdh"; }
        ];
        commandLineArgs = [
            "--enable-features=UseOzonePlatform"
            "--ozone-platform=wayland"
            "--enable-wayland-ime"
        ];
    };
}
