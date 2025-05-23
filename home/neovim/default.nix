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
            scrolloff = 10;
          };

          lsp = {
            formatOnSave = true;
            lightbulb.enable = true;
            trouble.enable = true;
            lspSignature.enable = true;
          };

          languages = {
            enableLSP = true;
            enableFormat = true;
            enableTreesitter = true;

            bash.enable = true;
            css.enable = true;
            ts.enable = true;
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

          diagnostics = {
            enable = true;
            config.virtual_lines = true;
          };

          autocomplete.nvim-cmp.enable = true;
          autopairs.nvim-autopairs.enable = true;
          binds = {
            whichKey.enable = true;
            cheatsheet.enable = true;
          };
          comments = {
            comment-nvim.enable = true;
          };
          git = {
            enable = true;
            gitsigns.enable = true;
            gitsigns.codeActions.enable = false;
          };
          spellcheck.enable = true;
          statusline.lualine = {
            enable = true;
            theme = "gruvbox";
          };
          telescope.enable = true;
          theme = {
            enable = true;
            name = "gruvbox";
            style = "dark";
          };
          treesitter = {
            enable = true;
            context.enable = true;
            indent.enable = true;
          };
          utility = {
            surround.enable = true;
            surround.useVendoredKeybindings = false;
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

  # Work around for the exec being `nvim "%F"` screwing with how files open
  xdg.desktopEntries.nvim = {
    name = "Neovim";
    icon = "nvim";
    exec = "nvim %F";
    comment = "Edit text files";
    categories = [ "TextEditor" ];
    terminal = true;
    mimeType = [ "text/plain" ];
    settings = {
      TryExec = "nvim";
      Keywords = "Text;editor;";
    };
  };
}
