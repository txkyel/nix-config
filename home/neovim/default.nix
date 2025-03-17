{
  inputs,
  pkgs,
  ...
}:
let
  customNeovim = inputs.nvf.lib.neovimConfiguration {
    inherit pkgs;
    modules = [
      {
        config.vim = {
          viAlias = true;
          vimAlias = true;
          useSystemClipboard = true;
          undoFile.enable = true;

          options = {
            autoindent = true;
            expandtab = true;
            shiftwidth = 4;
            tabstop = 4;
            wrap = false;
          };

          lsp = {
            formatOnSave = true;
          };

          languages = {
            enableLSP = true;
            enableFormat = true;
            enableTreesitter = true;

            nix = {
              enable = true;
              lsp.server = "nixd";
              format.type = "nixfmt";
            };
            python = {
              enable = true;
              lsp.server = "pyright";
            };
          };

          autocomplete.nvim-cmp.enable = true;
          autopairs.nvim-autopairs.enable = true;
          statusline.lualine.enable = true;
          telescope.enable = true;
          treesitter = {
            enable = true;
            context.enable = true;
            indent.enable = true;
          };
          visuals = {
            indent-blankline.enable = true;
          };

          # To get proper indentation for nix https://github.com/NotAShelf/nvf/pull/567
          pluginRC.nix = ''
            vim.api.nvim_create_autocmd("FileType", {
              pattern = "nix",
              callback = function(opts)
                local bo = vim.bo[opts.buf]
                bo.tabstop = 2
                bo.shiftwidth = 2
                bo.softtabstop = 2
              end
            })
          '';
        };
      }
    ];
  };
in
{
  home.packages = [ customNeovim.neovim ];
}
