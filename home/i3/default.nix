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
      };

      extraConfig = builtings.readFile ./config;
    };

    initExtra = "xset r rate 160 60";
  };
}

