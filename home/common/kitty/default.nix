{ config, pkgs, ... }:
{
  programs.kitty = {
    enable = true;

    shellIntegration = {
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    extraConfig = builtins.readFile ./kitty.conf;
  };

  home.file.".config/kitty/auri_theme.conf".source = ./auri_theme.conf;
}
