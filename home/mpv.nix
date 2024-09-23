{ pkgs, ... }:
{
    programs.mpv = {
        enable = true;
        bindings = {
            MBTN_LEFT = "cycle pause";
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

    # TODO: Enable single instance.
    # Like this with desktop entry and as default app
    # https://www.reddit.com/r/pop_os/comments/ox6t7n/run_mpv_in_single_instance/i1ojqw4/
}
