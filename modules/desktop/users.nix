{
  inputs,
  config,
  lib,
  pkgs,
  username,
  ...
}:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs username; };
    users.${username} = {
      # This is the home modules entry point
      imports = [ ./../../home ];
      home.username = "${username}";
      home.homeDirectory = "/home/${username}";
      home.stateVersion = config.system.stateVersion;
      programs.home-manager.enable = true;
    };
  };

  users.users.${username} = {
    isNormalUser = true;
    home = "/home/${username}";
    description = "${username}";
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
      "plugdev"
    ] ++ lib.optionals config.homelab.enable [ config.homelab.group ];
    shell = pkgs.zsh;
  };
}
