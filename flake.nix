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

      nixosConfigurations = import ./hosts inputs;
    };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
