{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    dotDir = ".config/zsh";

    shellAliases = {
      # Color aliases
      "ls" = "ls --color=auto --group-directories-first";
      "grep" = "grep --color=auto";
      "diff" = "diff --color=auto";
      "ip" = "ip -color=auto";
      # Misc
      "ll" = "ls -alF";
      "la" = "ls -A";
    };

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

    plugins = with pkgs; [
      {
        name = "vi-mode";
        src = zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
      {
        name = "fast-syntax-highlighting";
        src = zsh-fast-syntax-highlighting;
        file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
      }
      {
        name = "history-substring-search";
        src = zsh-history-substring-search;
        file = "share/zsh-history-substring-search/zsh-history-substring-search.zsh";
      }
      {
        name = "autosuggestions";
        src = zsh-autosuggestions;
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
