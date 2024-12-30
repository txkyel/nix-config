{ inputs, pkgs, pkgs-stable, host, username, ... }:
{
    imports = [ inputs.home-manager.nixosModules.home-manager ];
    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs pkgs-stable host username; };
        users.${username} = {
            # This is the home modules entry point
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
        extraGroups = [ "gamemode" "networkmanager" "wheel" ];
        shell = pkgs.zsh;
    };
}
