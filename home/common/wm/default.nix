{ ... }:
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

  xsession = {
    enable = true;

    initExtra = ''
      xset r rate 160 60
      hsetroot -solid "#5F6777"
    '';
  };
}

