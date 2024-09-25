{ pkgs, ... }:
{
    programs.mpv = {
        enable = true;
        bindings = {
            MBTN_LEFT = "cycle pause";
        };
        config = {
            keep-open = "yes";
        };
        scripts = with pkgs.mpvScripts; [
            modernx-zydezu
            mpris
            thumbfast
        ];
    };

    # ModernX config
    xdg.configFile."mpv/script-opts/modernx.conf".text = ''
        compactmode=no
        showontop=no
    '';
}
