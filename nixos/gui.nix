{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    libinput.enable = true;

    layout = "us";
    # TODO: Add xkboptions

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
