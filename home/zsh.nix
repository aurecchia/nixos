{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
  };
}
