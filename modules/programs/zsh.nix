{
  lib,
  pkgs,
  username,
  ...
}:
let
  inherit (builtins) filter;
  inherit (lib.attrsets) hasAttr;
  inherit (lib.strings) concatStringsSep optionalString;

  download_title = "[%(upload_date)s] %(title)s [%(id)s]";
  aliases = {
    # Color aliases
    "ls" = "ls --color=auto --group-directories-first";
    "grep" = "grep --color=auto";
    "diff" = "diff --color=auto";
    "ip" = "ip -color=auto";
    # Misc
    "ll" = "ls -alF";
    "la" = "ls -A";
    "ytd" = "noglob yt-dlp --embed-metadata --embed-thumbnail -i -o \"${download_title}.%(ext)s\"";
    "yta" = "ytd -x -f bestaudio/best";
    "ytarchive" = "noglob ytarchive --merge -t -w -o \"${download_title}\"";
  };

  mkPlugins =
    plugins:
    concatStringsSep "\n" (
      map (
        value:
        let
          hasFile = hasAttr "file" value;
        in
        concatStringsSep "\n" (
          filter (s: s != "") [
            (optionalString (!hasFile) "fpath+=${value.src}")
            (optionalString (hasFile && value.file != null) ''
              if [[ -f "${value.src}/${value.file}" ]]; then
                source "${value.src}/${value.file}"
              fi
            '')
          ]
        )
      ) plugins
    );

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
in
{
  config = {
    users.users.${username}.shell = pkgs.zsh;
    hj = {
      files = {
        # empty .zshrc to stop zsh-newuser stuff
        ".config/zsh/.zshrc".text = "# Empty file";
      };
    };

    environment.sessionVariables = {
      ZDOTDIR = "$HOME/.config/zsh";
    };
    programs.zsh = {
      enable = true;
      histFile = "$HOME/.local/share/zsh/zsh_history";
      histSize = 10000;
      shellAliases = aliases;
      setOptions = [
        "AUTOCD"
        "GLOBDOTS"
        "EXTENDED_HISTORY"
        "HIST_EXPIRE_DUPS_FIRST"
        "HIST_IGNORE_ALL_DUPS"
        "HIST_IGNORE_DUPS"
        "HIST_IGNORE_SPACE"
        "HIST_FIND_NO_DUPS"
        "HIST_SAVE_NO_DUPS"
        "SHARE_HISTORY"
      ];

      promptInit = ''
        function precmd() {
          local last_status=$?
          local indicators=""
          [[ -n $IN_NIX_SHELL ]] && indicators+="%F{blue} %f"

          # Prompt color based on last exit code
          local prompt_symbol="%F{green}$%f"
          [[ $last_status -ne 0 ]] && prompt_symbol="%F{red}$%f"

          PROMPT="$indicators %F{blue}%3~%f $prompt_symbol "
        }
      '';

      interactiveShellInit = ''
        # Fix kitty ssh jank
        [[ "$TERM" == "xterm-kitty" ]] && alias ssh='TERM=xterm-256color ssh'
          
        autoload -U compinit && compinit
        zstyle ':completion:*' menu select
        # Ignore case
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
        _comp_options+=(globdots)

        # Keybinds
        zmodload zsh/complist
        bindkey -M menuselect 'h' vi-backward-char
        bindkey -M menuselect 'j' vi-down-line-or-history
        bindkey -M menuselect 'k' vi-up-line-or-history
        bindkey -M menuselect 'l' vi-forward-char

        ${mkPlugins plugins}

        # After plugin is added
        bindkey '^[OA' history-substring-search-up
        bindkey '^[[A' history-substring-search-up
        bindkey '^[OB' history-substring-search-down
        bindkey '^[[B' history-substring-search-down
      '';
    };
  };
}
