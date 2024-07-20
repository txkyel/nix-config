{ pkgs, ... }:
{
    programs.zsh.enable = true;
    users.users.kyle = {
        isNormalUser = true;
        home = "/home/kyle";
        description = "kyle";
        extraGroups = [ "networkmanager" "wheel" ];
        shell = pkgs.zsh;
    };
}
