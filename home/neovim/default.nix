{ inputs, pkgs, ... }:
let
  customNeovim = inputs.nvf.lib.neovimConfiguration {
    inherit pkgs;
    modules = [
      {
        config.vim = {
          autocomplete.nvim-cmp.enable = true;
          statusline.lualine.enable = true;
          telescope.enable = true;

          languages = {
            enableLSP = true;
            enableTreesitter = true;

            languages.nix.enable = true;
            languages.python.enable = true;
          };
        };
      }
    ];
  };
in
{
  home.packages = [
    customNeovim.neovim
  ];
}
