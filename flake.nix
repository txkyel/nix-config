# Inspired by https://github.com/sioodmy/dotfiles/blob/d82f7db5080d0ff4d4920a11378e08df365aeeec/flake.nix
{
  description = "Kyle's NixOS flake";

  outputs =
    {
      nixpkgs,
      ...
    }@inputs:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "x86_64-linux"
      ];
    in
    {
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt);

      nixosModules = {
        # This module is not meant to be imported by anyone but me
        # it's just so I can easily avoid ../../../../../ mess
        system = import ./system;
      } // import ./modules;

      nixosConfigurations = import ./hosts inputs;
    };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    hyprland.url = "github:hyprwm/Hyprland";
    niri.url = "github:sodiboo/niri-flake";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
