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
    '';
  };
}
