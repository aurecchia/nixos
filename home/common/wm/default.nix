{ config, ... }:
{
  imports = [
    ./dunst.nix
    ./picom.nix
    ./polybar.nix
    ./i3.nix
  ];

  services = {
    redshift = {
      enable = true;
      tray = true;
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

  xsession = {
    enable = true;

    initExtra = ''
      xrdb -merge ~/.Xresources
      xrdb -merge ~/.Xresources.colors
      xset r rate 160 60
      hsetroot -solid "$(xrdb -query | grep 'background' | head -n1 | cut -f 2)"
      [[ ! -f ${config.xdg.configHome}/xsettingsd ]] && ln -s ${config.xdg.configHome}/xsettingsd.dark ${config.xdg.configHome}/xsettingsd;
    '';
  };
}

