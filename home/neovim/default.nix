{ inputs, pkgs, ... }:
let
  customNeovim = inputs.nvf.lib.neovimConfiguration {
    inherit pkgs;
    modules = [{
      config.vim = {
        viAlias = true;
        vimAlias = true;

        options = {
          autoindent = true;
          expandtab = true;
          shiftwidth = 4;
          smartindent = true;
          tabstop = 4;
        };

        languages = {
          enableLSP = true;
          enableFormat = true;

          nix.enable = true;
          python.enable = true;
        };

        autocomplete.nvim-cmp.enable = true;
        statusline.lualine.enable = true;
        telescope.enable = true;
        treesitter = {
          enable = true;
          context.enable = true;
          indent.enable = false;
        };
        visuals = {
          indent-blankline.enable = true;
        };
      };
    }];
  };
in { home.packages = [ customNeovim.neovim ]; }
