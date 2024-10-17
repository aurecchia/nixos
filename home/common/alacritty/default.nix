{ config, pkgs, colors, ... }:
{
  home.sessionVariables.TERMINAL = "alacritty";
  home.sessionVariables.TERM = "alacritty";

  programs.alacritty = {
    enable = true;

    settings = {
      import = [
        "~/.config/alacritty/colors.toml"
      ];

      ipc_socket = true;

      font = {
        size = 10.0;
        normal = {
          family = "Liberation Mono";
          style = "Regular";
        };
        bold = {
          family = "Liberation Mono";
          style = "Bold";
        };
        italic = {
          family = "Liberation Mono";
          style = "Italic";
        };
        bold_italic = {
          family = "Liberation Mono";
          style = "Bold Italic";
        };
      };


      keyboard.bindings = [
        { key = "c"; mods = "Control | Shift"; action = "Copy"; }
        { key = "v"; mods = "Control | Shift"; action = "Paste"; }
        { key = "+"; mods = "Control | Shift"; action = "IncreaseFontSize"; }
        { key = "-"; mods = "Control | Shift"; action = "DecreaseFontSize"; }
        { key = "="; mods = "Control | Shift"; action = "ResetFontSize"; }
      ];
    };
  };

  home.file.".config/alacritty/auri_dark.toml".text = ''
    # Based on Hybrid

    [colors.primary]
    background = '${colors.dark.background}'
    foreground = '${colors.dark.foreground}'

    [colors.cursor]
    cursor = '${colors.dark.cursor}'
    text =  '${colors.dark.foreground}'

    [colors.selection]
    background = '${colors.dark.selection_background}'
    text = '${colors.dark.selection_foreground}'

    [colors.normal]
    black = '${colors.dark.color0}'
    red = '${colors.dark.color1}'
    green = '${colors.dark.color2}'
    yellow = '${colors.dark.color3}'
    blue = '${colors.dark.color4}'
    magenta = '${colors.dark.color5}'
    cyan = '${colors.dark.color6}'
    white = '${colors.dark.color7}'

    [colors.bright]
    black = '${colors.dark.color8}'
    red = '${colors.dark.color9}'
    green = '${colors.dark.color10}'
    yellow = '${colors.dark.color11}'
    blue = '${colors.dark.color12}'
    magenta = '${colors.dark.color13}'
    cyan = '${colors.dark.color14}'
    white = '${colors.dark.color15}'
  '';

  home.file.".config/alacritty/auri_light.toml".text = ''
    # Based on Ayu light

    [colors.primary]
    background = '#fafafa'
    foreground = '#5b6673'

    [colors.cursor]
    cursor = '#ff6900'
    text = '#5b6673'

    [colors.selection]
    background = '#f0ede4'
    text = '#fafafa'

    [colors.normal]
    black = '#000000'
    red = '#ff3333'
    green = '${colors.dark.color2}'
    yellow = '#f19618'
    blue = '#41a6d9'
    magenta = '#f07078'
    cyan = '#4cbe99'
    white = '#ffffff'

    [colors.bright]
    black = '#323232'
    red = '#ff6565'
    green = '${colors.dark.color10}'
    yellow = '#ffc849'
    blue = '#73d7ff'
    magenta = '#ffa3aa'
    cyan = '#7ff0cb'
    white = '#ffffff'
  '';
}

