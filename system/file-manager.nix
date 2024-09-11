{ pkgs, ... }:
{
    # https://github.com/Stunkymonkey/nautilus-open-any-terminal/tree/bb0fe33c48770ae9774ad27034152d185def2b67#nixpkgs-nixos-
    programs.nautilus-open-any-terminal = {
        enable = true;
        terminal = "kitty";
    };
    
    environment = {
        sessionVariables.NAUTILUS_4_EXTENSION_DIR = "${pkgs.gnome.nautilus-python}/lib/nautilus/extensions-4";
        pathsToLink = [
            "/share/nautilus-python/extensions"
        ];
    
        systemPackages = with pkgs.gnome; [
            nautilus
            nautilus-python
        ];
    };

    services.gvfs.enable = true;
}
