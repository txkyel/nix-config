{ pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        brightnessctl

        # Screenshot
        grim
        slurp
        swappy

    ];
}
