{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Alessio Aurecchia";
    userEmail = "alessio@aurecchia.ch";
  };
}
