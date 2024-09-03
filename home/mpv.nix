{ pkgs, ... }:
{
    programs.mpv = {
        enable = true;
        bindings = {
            MBTN_LEFT = "cycle pause";
        };
        scripts = with pkgs; [
            mpvScripts.mpris
        ];
    };
}
