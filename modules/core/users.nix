{
  inputs,
  lib,
  config,
  username,
  pkgs,
  ...
}:
let
  inherit (lib) mkAliasOptionModule;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.hjem.nixosModules.default
    (mkAliasOptionModule [ "hj" ] [ "hjem" "users" username ])
    (mkAliasOptionModule [ "hm" ] [ "home-manager" "users" username ])
  ];

  config = {
    users.users.${username} = {
      isNormalUser = true;
      description = "${username}";
      extraGroups = [
        "networkmanager"
        "wheel"
        "dialout"
        "plugdev"
      ] ++ lib.optionals config.homelab.enable [ config.homelab.group ];
    };

    hjem = {
      clobberByDefault = true;
      users.${username} = {
        enable = true;
        directory = "/home/${username}";
        user = "${username}";
      };
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = { inherit inputs username; };
      users.${username} = {
        # This is the home modules entry point
        imports = [ ];
        home.username = "${username}";
        home.homeDirectory = "/home/${username}";
        home.stateVersion = config.system.stateVersion;
        programs.home-manager.enable = true;
      };
    };
  };
}
