{ config, pkgs, ... }:
let
  inherit (config.colorscheme) colors;
in
{
  programs.kitty = {
    enable = true;

    shellIntegration = {
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    extraConfig = builtins.readFile ./kitty.conf;
  };
}
