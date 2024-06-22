{ config, ... }: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    clipboard = {
      register = "unnamedplus";
      providers.xclip.enable = true;
    };
    opts = {
      # Appearance
      number = true;
      relativenumber = true;
      termguicolors = true;
      colorcolumn = "100";
      signcolumn = "yes";
      scrolloff = 10;
      wrap = false;

      # Tab
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      smartindent = true;

      # Behaviour
      incsearch = true;
      ignorecase = true;
      smartcase = true;
      hlsearch = false;
      hidden = true;
      errorbells = false;
      swapfile = false;
      backup = false;
      undodir = "${config.xdg.cacheHome}/vim/undodir";
      undofile = true;
    };
  };
}
