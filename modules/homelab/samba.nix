{
  config,
  lib,
  ...
}:
let
  homelab = config.homelab;
  cfg = homelab.samba;
in
{
  options.homelab.samba = {
    enable = lib.mkEnableOption "Enable samba";

    commonShareSettings = lib.mkOption {
      description = "Settings applied to each share";
      type = lib.types.attrsOf lib.types.str;
      example = {
        "security" = "user";
        "invalid users" = [ "root" ];
      };
      default = {
        "preserve case" = "yes";
        "short preserve case" = "yes";
        "browseable" = "yes";
        "writeable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "valid users" = homelab.user;
      };
    };

    shares = lib.mkOption {
      type = lib.types.attrs;
      example = lib.literalExpression ''
        CoolShare = {
          path = "/mnt/CoolShare";
          "fruit:aapl" = "yes";
        };
      '';
      default = { };
    };
  };

  config = lib.mkIf (homelab.enable && cfg.enable) {
    systemd.tmpfiles.rules = map (share: "d ${share.path} 0775 ${homelab.user} ${homelab.group} - -") (
      lib.attrValues cfg.shares
    );

    services.samba = {
      enable = true;
      openFirewall = true;
      settings = {
        global = {
          workgroup = "WORKGROUP";
          "server string" = config.networking.hostName;
          "netbios name" = config.networking.hostName;
          "security" = "user";
          "invalid users" = [ "root" ];
          "hosts allow" = [ "192.168.0. 127.0.0.1 localhost" ];
          "guest account" = "nobody";
          "map to guest" = "bad user";
        };
      } // builtins.mapAttrs (name: value: value // cfg.commonShareSettings) cfg.shares;
    };

    services.avahi = {
      enable = true;
      openFirewall = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        userServices = true;
      };
    };
  };
}
