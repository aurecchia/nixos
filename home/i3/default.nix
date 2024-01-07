{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
in {
  xsession = {
    enable = true;

    windowManager.i3 = {
      enable = true;
   
      config = {
        modifier = mod;

        fonts = {
          names = [ "JetBrains Mono" ];
          size = 10.0;
        };
        
        keybindings = {
          "${mod}+q" = "kill";

          # Launchers
          "${mod}+space" = "exec rofi -show run";
          "${mod}+Return" = "exec rofi -show drun -show-icons";
          "${mod}+b" = "bar mode toggle";
          "${mod}+c" = "exec find ~/.scripts -executable -type f | dmenu $dmenu_opts | /bin/sh &";
          "${mod}+e" = "exec emoji-picker";
          "${mod}+f" = "exec thunar";
          #"${mod}+g" = "exec ~/.scripts/i3-wm-scripts/nextfind.py $dmenu_opts -l 10";
          "${mod}+t" = "exec kitty";
          "${mod}+w" = "exec firefox-dev";
        };
      };

      # extraConfig = builtins.readFile ./config;
    };

    initExtra = "xset r rate 160 60";
  };
}

