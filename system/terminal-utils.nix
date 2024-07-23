{ pkgs, ... }:
{
    # TODO: Move/reorganize, this file has too vague of a scope
    programs.zsh.enable = true;
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
