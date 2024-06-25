{
  description = "My flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

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

    # Hyprland inputs
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    wallust.url = "git+https://codeberg.org/explosion-mental/wallust?ref=dev";
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    home-manager,
    kmonad,
    nixvim,
    ...
  }@inputs:
    let 
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
  {
    nixosConfigurations = {
      virtualbox-nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/vm
        ];
      };

      x230 = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          nixos-hardware.nixosModules.lenovo-thinkpad-x230
          kmonad.nixosModules.default
          ./hosts/x230
        ];
      };
    };

    homeConfigurations = {
      kyle = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          nixvim.homeManagerModules.nixvim
          ./home
        ];
      };
    };
  };
}
