{ config, lib, pkgs, ... }:

{
  programs.fzf.enable = true;

  programs.zsh = {
    enable = true;

    defaultKeymap = "emacs";

    enableCompletion = true;
    autosuggestion.enable = true;

    cdpath = [ "~/repos/valora" ];

    shellAliases = {
      la = "ls -ah";
      ll = "ls -lah";
      n = "vim ~/repos/notes/notes.md";
    };

    history = {
      # Number of entries that are saved
      save = 1000000;
      # Number of entries that are loaded
      size = 1000000;
      ignoreAllDups = true;
      expireDuplicatesFirst = true;
    };

    initExtra = ''
      if [ -n "$${commands[fzf-share]}" ]; then
        source "$(fzf-share)/key-bindings.zsh"
        source "$(fzf-share)/completion.zsh"
      fi

      # lowercase matches both upper- and lowercase in completions
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

      AGKOZAK_PROMPT_DIRTRIM=4
      AGKOZAK_LEFT_PROMPT_ONLY=1
      AGKOZAK_BLANK_LINES=1
      AGKOZAK_PROMPT_CHAR=( $ %# : )
      AGKOZAK_COLORS_USER_HOST=white
      AGKOZAK_COLORS_PATH=gray
      AGKOZAK_COLORS_CMD_EXEC_TIME=magenta
      AGKOZAK_CUSTOM_SYMBOLS=( '⇣⇡' '⇣' '⇡' '+' 'x' '!' '>' '?' 'S')

      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=$(xrdb -query | grep '*.shaded' | head -n1 | cut -f 2)"
      ZSH_AUTOSUGGEST_STRATEGY=(completion history)

      autoload -U edit-command-line
      zle -N edit-command-line
      bindkey '^xe' edit-command-line
      bindkey '^x^e' edit-command-line

      export PATH="$PATH:/home/auri/.dotnet/tools"
    '';

    plugins = [
      {
        name = "agkozak-zsh-prompt";
        src = pkgs.fetchFromGitHub {
          owner = "agkozak";
          repo = "agkozak-zsh-prompt";
          rev = "v3.11.2";
          sha256 = "sha256-QDUI9EYflITttkX9Khij62ybBMYJwPfayqj+wr495mM=";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.6.0";
          sha256 = "0zmq66dzasmr5pwribyh4kbkk23jxbpdw4rjxx0i7dx8jjp2lzl4";
        };
      }
      {
        name = "zsh-autopair";
        src = pkgs.fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "34a8bca0c18fcf3ab1561caef9790abffc1d3d49";
          sha256 = "1h0vm2dgrmb8i2pvsgis3lshc5b0ad846836m62y8h3rdb3zmpy1";
        };
      }
      {
        name = "gitit";
        src = pkgs.fetchFromGitHub {
          owner = "peterhurford";
          repo = "git-it-on.zsh";
          rev = "4827030e1ead6124e3e7c575c0dd375a9c6081a2";
          sha256 = "01xsqhygbxmv38vwfzvs7b16iq130d2r917a5dnx8l4aijx282j2";
        };
      }
    ];
  };
}
