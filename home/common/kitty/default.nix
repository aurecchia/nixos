{ config, pkgs, colors, ... }:
{
  home.sessionVariables.TERMINAL = "kitty";
  home.sessionVariables.TERM = "kitty";

  programs.kitty = {
    enable = true;

    shellIntegration = {
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    extraConfig = builtins.readFile ./kitty.conf;
  };

  home.file.".config/kitty/auri_theme.conf".text = ''
    # Based on Hybrid

    background   ${colors.dark.background}
    foreground   ${colors.dark.foreground}

    cursor       ${colors.dark.cursor}
    selection_background ${colors.dark.selection_background}
    selection_foreground ${colors.dark.selection_foreground}

    # black
    color0       ${colors.dark.color0}
    color8       ${colors.dark.color8}

    # red
    color1       ${colors.dark.color1}
    color9       ${colors.dark.color9}

    # green
    color2       ${colors.dark.color2}
    color10      ${colors.dark.color10}

    # yellow
    color3       ${colors.dark.color3}
    color11      ${colors.dark.color11}

    # blue
    color4       ${colors.dark.color4}
    color12      ${colors.dark.color12}

    # magenta
    color5       ${colors.dark.color5}
    color13      ${colors.dark.color13}

    # cyan
    color6       ${colors.dark.color6}
    color14      ${colors.dark.color14}

    # white
    color7       ${colors.dark.color7}
    color15      ${colors.dark.color15}
  '';
}
