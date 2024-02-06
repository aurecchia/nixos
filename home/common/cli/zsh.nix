{ config, lib, pkgs, ... }:

{
  programs.fzf.enable = true;

  programs.zsh = {
    enable = true;

    defaultKeymap = "emacs";

    cdpath = [ "~/repos/valora" ];

    initExtra = ''
      if [ -n "$${commands[fzf-share]}" ]; then
        source "$(fzf-share)/key-bindings.zsh"
        source "$(fzf-share)/completion.zsh"
      fi

      AGKOZAK_PROMPT_DIRTRIM=4
      AGKOZAK_BLANK_LINES=1
      AGKOZAK_PROMPT_CHAR=( λ %# : )
      AGKOZAK_CUSTOM_SYMBOLS=( '⇣⇡' '⇣' '⇡' '+' 'x' '!' '>' '?' 'S')
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
    ];
  };
}
