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
    [colors.primary]
    background = '${colors.light.background}'
    foreground = '${colors.light.foreground}'

    [colors.cursor]
    cursor = '${colors.light.cursor}'
    text =  '${colors.light.foreground}'

    [colors.selection]
    background = '${colors.light.selection_background}'
    text = '${colors.light.selection_foreground}'

    [colors.normal]
    black = '${colors.light.color0}'
    red = '${colors.light.color1}'
    green = '${colors.light.color2}'
    yellow = '${colors.light.color3}'
    blue = '${colors.light.color4}'
    magenta = '${colors.light.color5}'
    cyan = '${colors.light.color6}'
    white = '${colors.light.color7}'

    [colors.bright]
    black = '${colors.light.color8}'
    red = '${colors.light.color9}'
    green = '${colors.light.color10}'
    yellow = '${colors.light.color11}'
    blue = '${colors.light.color12}'
    magenta = '${colors.light.color13}'
    cyan = '${colors.light.color14}'
    white = '${colors.light.color15}'
  '';
}

