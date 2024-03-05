{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;

    font = "Inter SemiBold 16";

    extraConfig = {
      modi = "window,run,ssh";
      fixed-num-lines = true;
      show-icons = true;
      icon-theme = "GNOME";
      drun-display-format = "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";  
     #timeout = {
     #    action = "kb-cancel";
     #    delay =  0;
     #};
     #filebrowser = {
     #    directories-first = true;
     #    sorting-method = "name";
     #};
    };

    theme = ./jellybeans.rasi;
  };
}
