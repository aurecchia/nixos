{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    libinput.enable = true;

    layout = "us";
    xkbVariant = "";
    # TODO: Add xkboptions

    resolutions = [
      { x = 2560; y = 1600; }
      { x = 1920; y = 1080; } ];
    dpi = 140;

    displayManager = {
      lightdm.enable = true;
      defaultSession = "xsession";
      session = [
        {
          manage = "desktop";
          name = "xsession";
          start = ''exec $HOME/.session'';
        }
      ];
    };
  };
}
