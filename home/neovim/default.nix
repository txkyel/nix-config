{ inputs, pkgs, ... }:
let
  customNeovim = inputs.nvf.lib.neovimConfiguration {
    inherit pkgs;
    modules = [{
      config.vim = {
        viAlias = true;
        vimAlias = true;
        autocomplete.nvim-cmp.enable = true;
        statusline.lualine.enable = true;
        telescope.enable = true;

        languages = {
          enableLSP = true;
          enableFormat = true;
          enableTreesitter = true;

          nix.enable = true;
          python.enable = true;
        };
      };
    }];
  };
in { home.packages = [ customNeovim.neovim ]; }
