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

  home.file.".config/kitty/auri_dark.conf".text = ''
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

  home.file.".config/kitty/auri_light.conf".text = ''
    # Based on Ayu light
    font_family      JetBrains Mono Bold

    background            #fafafa
    foreground            #5b6673

    cursor                #ff6900
    selection_foreground  #fafafa
    selection_background  #f0ede4

    # black
    color0                #000000
    color8                #323232

    # red
    color1                #ff3333
    color9                #ff6565

    # green
   #color2                #86b200
   #color10               #b8e532
    color2       ${colors.dark.color2}
    color10      ${colors.dark.color10}

    # yellow
    color3                #f19618
    color11               #ffc849

    # blue
    color4                #41a6d9
    color12               #73d7ff

    # magenta
    color5                #f07078
    color13               #ffa3aa

    # cyan
    color6                #4cbe99
    color14               #7ff0cb

    # white
    color7                #ffffff
    color15               #ffffff
  '';
}
