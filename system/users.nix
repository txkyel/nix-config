{ inputs, pkgs, host, username, ... }:
{
    imports = [ inputs.home-manager.nixosModules.home-manager ];
    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs host username; };
        users.${username} = {
            imports = [ ./../home ];
            home.username = "${username}";
            home.homeDirectory = "/home/${username}";
            home.stateVersion = "24.05";
            programs.home-manager.enable = true;
        };
    };

    users.users.${username} = {
        isNormalUser = true;
        home = "/home/${username}";
        description = "${username}";
        extraGroups = [ "networkmanager" "wheel" ];
        shell = pkgs.zsh;
    };
}
