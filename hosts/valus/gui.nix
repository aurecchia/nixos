{ config, pkgs, ... }:

{
  console.font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";

  environment.variables = {
    GDK_SCALE = "1";
    GDK_DPI_SCALE = "1";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };

  services.libinput.enable = true;

  services.displayManager.defaultSession = "xsession";
  services.xserver = {
    enable = true;

    # videoDrivers = [ "amdgpu-pro" ];
    videoDrivers = [ "amdgpu" ];

    xkb = {
      layout = "us";
      variant = "altgr-intl";
    };

    resolutions = [
      { x = 3840; y = 2160; }
      { x = 2560; y = 1600; }
      { x = 1920; y = 1080; } ];

    dpi = 140;

    xrandrHeads = [
      {
        output = "DisplayPort-2";
        primary = true;
        monitorConfig = ''
          Option "TearFree" "on"
        '';
      }
      {
        output = "HDMI-A-0";
        monitorConfig = ''
          Option "Rotate" "right"
          Option "LeftOf" "DisplaPort-2"
          Option "TearFree" "on"
        '';
      }
    ];

    displayManager = {
      lightdm.enable = true;
      session = [
        {
          manage = "desktop";
          name = "xsession";
          start = ''exec $HOME/.session'';
        }
      ];

      setupCommands = ''
        LEFT='HDMI-A-0'
        CENTER='DisplayPort-2'
        ${pkgs.xorg.xrandr}/bin/xrandr --output $CENTER --primary --output $LEFT --left-of $CENTER --rotate right
      '';
    };

    desktopManager = {
      gnome.enable = false;
      plasma5.enable = false;
      xterm.enable = false;
    };
  };

  services.colord.enable = true;
}
