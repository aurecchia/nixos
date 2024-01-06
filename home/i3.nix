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
    };

    initExtra = "xset r rate 160 60";
  };
}

