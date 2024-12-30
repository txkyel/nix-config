{
    description = "My flake";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        nixpkgs-stable.url = "nixpkgs/nixos-24.11";
        nixos-hardware.url = "github:NixOS/nixos-hardware/master";
        hyprland.url = "github:hyprwm/Hyprland?submodules=1";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        kmonad = {
            url = "github:kmonad/kmonad?submodules=1&dir=nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nixvim = {
            url = "github:nix-community/nixvim";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, nixpkgs-stable, ... }@inputs:
    let
        system = "x86_64-linux";
        pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
        };
        pkgs-stable = import nixpkgs-stable {
            inherit system;
            config.allowUnfree = true;
        };
        username = "kyle";
    in
    {
        nixosConfigurations = {
            desktop = nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = {
                    host = "desktop";
                    inherit inputs username pkgs-stable;
                };
                modules = [
                    ./hosts/desktop
                    ./system
                ];
            };

            x230 = nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = {
                    host = "x230";
                    inherit inputs username pkgs-stable;
                };
                modules = [
                    ./hosts/x230
                    ./system
                ];
            };

            vm = nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = {
                    host = "vm";
                    inherit inputs username pkgs-stable;
                };
                modules = [
                    ./hosts/vm
                    ./system
                ];
            };
        };
    };
}
