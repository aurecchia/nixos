{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
in {
  xsession.enable = true;
  xsession.windowManager.i3 = {
    enable = true;

    config = {
      modifier = mod;
    };
  };
}

