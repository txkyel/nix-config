{ inputs, pkgs, ... }:

{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ./programs ];
}
