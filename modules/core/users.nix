{ pkgs, ... }:
{
  users.users.kyle = {
    isNormalUser = true;
    home = "/home/kyle";
    description = "kyle";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };
  nix.settings.allowed-users = [ "kyle" ];
}
