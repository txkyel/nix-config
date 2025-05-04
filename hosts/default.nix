{
  self,
  nixpkgs,
  ...
}:
let
  inherit (self) inputs;

  mkHost =
    name: system:
    nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./${name}
      ] ++ builtins.attrValues self.nixosModules;

      specialArgs = {
        host = name;
        username = "kyle";
        inherit inputs;
      };
    };
in
{
  desktop = mkHost "desktop" "x86_64-linux";
  x230 = mkHost "x230" "x86_64-linux";
}
