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

          options = {
            autoindent = true;
            expandtab = true;
            shiftwidth = 4;
            tabstop = 4;
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
        };
      }
    ];
  };
in
{
  home.packages = [ customNeovim.neovim ];
}
