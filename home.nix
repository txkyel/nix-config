{ inputs, config, pkgs, ... }:

{
  # TODO: Figure out how to link to global nixpkgs instead of setting option for instanced nixpkgs
  nixpkgs.config.allowUnfree = true;
  home.username = "kyle";
  home.homeDirectory = "/home/kyle";
  home.stateVersion = "24.05"; # Please read the comment before changing.
  home.packages = with pkgs; [
    alacritty
    rofi
    picom
    maim
    brave
    google-chrome
    pavucontrol
    playerctl
    (pkgs.discord.override {
      withVencord = true;
    })
  ];
  home.file = {
    qtile_config = {
      source = ./qtile/config.py;
      target = ".config/qtile/config.py";
    };
  };
  home.sessionVariables = {};

  # Enable xdg
  xdg.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userEmail = "kylexiao20@gmail.com";
    userName = "Kyle Xiao";
  };

  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    window.padding = {
      x = 8;
      y = 8;
    };
  };

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

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    autocd = true;
    enableCompletion = true;
    completionInit = ''
      autoload -U compinit && compinit
      zstyle ':completion:*' menu select
      _comp_options+=(globdots)

      # Keybinds
      zmodload zsh/complist
      bindkey -M menuselect 'h' vi-backward-char
      bindkey -M menuselect 'j' vi-down-line-or-history
      bindkey -M menuselect 'k' vi-up-line-or-history
      bindkey -M menuselect 'l' vi-forward-char
    '';

    history = {
      ignoreDups = true;
      ignoreSpace = true;
      save = 100000;
      size = 100000;
      share = true;
      path = "${config.xdg.dataHome}/zsh/zsh_history";
    };

    plugins = [
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
      {
        name = "fast-syntax-highlighting";
        src = pkgs.zsh-fast-syntax-highlighting;
        file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
      }
      {
        name = "history-substring-search";
        src = pkgs.zsh-history-substring-search;
        file = "share/zsh-history-substring-search/zsh-history-substring-search.zsh";
      }
      {
        name = "autosuggestions";
        src = pkgs.zsh-autosuggestions;
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
      }
    ];

    initExtra = ''
      PROMPT="%F{blue}%~ %(?.%F{green}.%F{red})%#%f "
      bindkey '^[OA' history-substring-search-up
      bindkey '^[[A' history-substring-search-up
      bindkey '^[OB' history-substring-search-down
      bindkey '^[[B' history-substring-search-down
    '';
  };
}
