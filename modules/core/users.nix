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
    inputs.hjem.nixosModules.default
    (mkAliasOptionModule [ "hj" ] [ "hjem" "users" username ])
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
      linker = inputs.hjem.packages.${pkgs.system}.smfh;
      clobberByDefault = true;
      users.${username} = {
        enable = true;
        directory = "/home/${username}";
        user = "${username}";
      };
    };
  };
}
