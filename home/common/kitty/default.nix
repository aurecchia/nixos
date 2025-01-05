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
    # Polar Colorscheme for Kitty
    # Based on:
    # - https://gist.github.com/marcusramberg/64010234c95a93d953e8c79fdaf94192
    # - https://github.com/arcticicestudio/nord-hyper

    active_border_color #81A1C1

    foreground            #2E3440
    background            #F9FAFB
    selection_foreground  #FFFACD
    selection_background  #000000
    url_color             #0087BD
    cursor                #81A1C1

    color0   #3B4252
    color8   #4C566A

    color1   #BF616A
    color9   #BF616A

    color2   #A3BE8C
    color10  #A3BE8C

    color3   #EBCB8B
    color11  #EBCB8B

    color4  #5E81AC
    color12 #81A1C1

    color5   #B48EAD
    color13  #B48EAD

    color6   #88C0D0
    color14  #8FBCBB

    color7   #D8DEE9
    color15  #E5E9F0
  '';
}
