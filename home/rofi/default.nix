{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;

    extraConfig = builtins.readFile ./config.rasi;
    theme = ./jellybeans.rasi;
  };
}
