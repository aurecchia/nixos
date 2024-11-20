{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    mouse = true;
    plugins = with pkgs.tmuxPlugins; [
      sensible
    ];
    extraConfig = ''
      unbind C-b
      set -g prefix C-Space
      bind C-Space send-prefix

      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      set-option -g status-style bg=black,fg=cyan
    '';
  };
}
