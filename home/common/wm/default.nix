{ config, colors, ... }:
{
  imports = [
    ./dunst.nix
    ./picom.nix
    ./polybar.nix
    ./i3.nix
  ];

  services = { redshift = { enable = true; tray = true;
      provider = "geoclue2";
      settings.redshift.adjustment-method = "randr";
    };
  };

  home.file."${config.xdg.configHome}/xsettingsd.dark".text = ''
    Net/ApplicationPreferDarkTheme 1
    Gtk/ApplicationPreferDarkTheme 1
    Net/ThemeName "Adwaita-dark"
  '';

  home.file."${config.xdg.configHome}/xsettingsd.light".text = ''
    Net/ApplicationPreferDarkTheme 0
    Gtk/ApplicationPreferDarkTheme 0
    Net/ThemeName "Adwaita"
  '';

  home.file.".Xresources.light".text = ''
    *.background: ${colors.light.background}
    *.foreground: ${colors.light.foreground}
    *.shaded:     ${colors.light.dimmed}

    *.cursor: ${colors.light.cursor}
    *.selection_background: ${colors.light.selection_background}
    *.selection_foreground: ${colors.light.selection_foreground}

    ! black
    *.color0: ${colors.light.color0}
    *.color8: ${colors.light.color8}

    ! red
    *.color1: ${colors.light.color1}
    *.color9: ${colors.light.color9}

    ! green
    *.color2: ${colors.light.color2}
    *.color10: ${colors.light.color10}

    ! yellow
    *.color3: ${colors.light.color3}
    *.color11: ${colors.light.color11}

    ! blue
    *.color4: ${colors.light.color4}
    *.color12: ${colors.light.color12}

    ! magenta
    *.color5: ${colors.light.color5}
    *.color13: ${colors.light.color13}

    ! cyan
    *.color6: ${colors.light.color6}
    *.color14: ${colors.light.color14}

    ! white
    *.color7: ${colors.light.color7}
    *.color15: ${colors.light.color15}


    desktop.background: ${colors.light.desktop}

    i3.background: #101010
    i3.foreground: #ffffff
    i3.barDimmed: ${colors.dark.dimmed}

    i3.focusedBg: ${colors.dark.color4}
    i3.focusedFg: ${colors.dark.foreground}
    i3.focusedBorder: ${colors.dark.color4}
    i3.indicator: ${colors.dark.color4}

    i3.inactiveBg: ${colors.dark.color7}
    i3.inactiveFg: ${colors.dark.color15}
    i3.inactiveBorder: ${colors.dark.color7}

    i3.unfocusedBg: ${colors.dark.color0}
    i3.unfocusedFg: ${colors.dark.color7}
    i3.unfocusedBorder: ${colors.dark.background}

    i3.urgentBg:${colors.dark.color2}
    i3.urgentFg: #ffffff
    i3.urgentBorder: ${colors.dark.color2}

    i3.placeholderBg: ${colors.dark.color7}
    i3.placeholderFg: #ffffff
    i3.placeholderBorder: ${colors.dark.color7}
  '';

  home.file.".Xresources.dark".text = ''
    *.background: ${colors.dark.background}
    *.foreground: ${colors.dark.foreground}
    *.shaded:     ${colors.dark.dimmed}

    *.cursor: ${colors.dark.cursor}
    *.selection_background: ${colors.dark.selection_background}
    *.selection_foreground: ${colors.dark.selection_foreground}

    ! black
    *.color0: ${colors.dark.color0}
    *.color8: ${colors.dark.color8}
    *.color1: ${colors.dark.color1}
    *.color9: ${colors.dark.color9}

    ! green
    *.color2: ${colors.dark.color2}
    *.color10: ${colors.dark.color10}

    ! yellow
    *.color3: ${colors.dark.color3}
    *.color11: ${colors.dark.color11}

    ! blue
    *.color4: ${colors.dark.color4}
    *.color12: ${colors.dark.color12}

    ! magenta
    *.color5: ${colors.dark.color5}
    *.color13: ${colors.dark.color13}

    ! cyan
    *.color6: ${colors.dark.color6}
    *.color14: ${colors.dark.color14}

    ! white
    *.color7: ${colors.dark.color7}
    *.color15: ${colors.dark.color15}

    desktop.background: ${colors.dark.desktop}

    i3.background: ${colors.dark.background}
    i3.foreground: ${colors.dark.foreground}
    i3.barDimmed: ${colors.dark.dimmed}

    i3.focusedBg: ${colors.dark.color4}
    i3.focusedFg: ${colors.dark.foreground}
    i3.focusedBorder: ${colors.dark.color4}
    i3.indicator: ${colors.dark.color4}

    i3.inactiveBg: ${colors.dark.color7}
    i3.inactiveFg: ${colors.dark.color15}
    i3.inactiveBorder: ${colors.dark.color7}

    i3.unfocusedBg: ${colors.dark.color0}
    i3.unfocusedFg: ${colors.dark.color7}
    i3.unfocusedBorder: ${colors.dark.background}

    i3.urgentBg:${colors.dark.color2}
    i3.urgentFg: #ffffff
    i3.urgentBorder: ${colors.dark.color2}

    i3.placeholderBg: ${colors.dark.color7}
    i3.placeholderFg: #ffffff
    i3.placeholderBorder: ${colors.dark.color7}
  '';

  xresources.extraConfig = ''
    #include ".Xresources.colors"
  '';

  xsession = {
    enable = true;

    initExtra = ''
      xrdb -merge ~/.Xresources
      xrdb -merge ~/.Xresources.colors
      xset r rate 160 60
      hsetroot -solid "$(xrdb -query | grep 'desktop.background' | head -n1 | cut -f 2)"
      [[ ! -f ${config.xdg.configHome}/xsettingsd ]] && ln -s ${config.xdg.configHome}/xsettingsd.dark ${config.xdg.configHome}/xsettingsd;
    '';
  };
}

