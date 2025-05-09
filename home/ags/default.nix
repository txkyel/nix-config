{
  inputs,
  pkgs,
  ...
}:
{
  imports = [ inputs.ags.homeManagerModules.default ];

  programs.ags.enable = true;
  programs.ags.extraPackages = builtins.attrValues inputs.ags.packages.${pkgs.system};
  programs.ags.systemd.enable = true;
}
