{ pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        git
        curl
        wget
        ntfs3g
        zip
        unzip
        _7zz

        btop
        cava # remove?

        # Required for hyprland
        jq
    ];
}
