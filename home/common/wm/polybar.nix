{ pkgs, ... }:
 let
  fg = "#fefefe";
  bg = "#202020";
  font =  "Inter SemiBold:size=15;6";
  font-bold =  "Inter SemiBold:size=15;6";
  height = 42;
  border-bottom-size = 2;
  padding = 3;
in
{
  services.polybar = {
    enable = true;

    package = pkgs.polybar.override {
      i3Support = true;
    };

    script = ''
      polybar -q --reload center &
      polybar -q --reload left &
    '';

    config = {
      "global/wm" = {
        dpi = 140;
        format-padding = 1;

        bottom = false;
        width = "100%";

        # separator = "/";
        # separator-foreground = "#585858";

        foreground = fg;
        background = bg;
      };

      "bar/center" = {
        monitor = "DisplayPort-2";
        height = height;

        font-0 = font;
        font-1 = font-bold;

        border-bottom-size = border-bottom-size;
        border-bottom-color = "#000000";

        modules-left = "i3";
        modules-right = "memory cpu time tray";
      };

      "bar/left" = {
        monitor = "HDMI-A-0";
        height = height;

        font-0 = font;
        font-1 = font-bold;

        border-bottom-size = border-bottom-size;
        border-bottom-color = "#000000";

        modules-left = "i3";
      };

      "module/i3" = {
        type = "internal/i3";
        pin-workspaces = true;

        # strip-wsnumbers = true;
        format = "<label-mode><label-state>";
        # format-background = tertiary;

        # label-mode = "%mode%";
        label-mode-foreground = "#005f00";
        label-mode-background = "#afdf00";
        label-mode-padding = padding;

        label-focused = "%{T2}%name%%{T-}";
        # label-focused-foreground = "#ffffff";
        # label-focused-background = "#005F87";
        label-focused-foreground = "#ffffff";
        label-focused-background = "#000000";
        label-focused-padding = padding;

        label-unfocused = "%name%";
        # label-unfocused-foreground = "#585858";
        # label-unfocused-background = "#2a2a2a";
        label-unfocused-foreground = "#666666";
        label-unfocused-background = "#000000";
        label-unfocused-padding = padding;

        label-visible = "%name%";
        # label-visible-foreground = "#585858";
        # label-visible-background = "#2a2a2a";
        label-visible-foreground = "#666666";
        label-visible-background = "#000000";
        label-visible-padding = padding;

        label-urgent = "%name%";
        label-urgent-foreground = "#ffffff";
        label-urgent-background = "#a7004F";
        label-urgent-padding = padding;

        label-separator = "";
        label-separator-padding = 0;
        label-separator-background = "#000000";
      };

      "module/title" = {
        type = "internal/xwindow";
        format = "<label>";
        format-padding = padding;
        format-foreground = "#ffffff";
        label = "%title%";
        label-maxlen = 70;
      };

      "module/network" = {
        type = "internal/network";

        # TODO: pick this up automatically
        interface = "wlp6s0";
        interval = "5.0";
        format-padding = 1;

        format-connected = "<label-connected>";
        format-connected-padding = 1;
        label-connected = "%essid% (%local_ip% / %local_ip6%)";

        format-disconnected = "<label-disconnected>";
        format-disconnected-padding = 1;
        label-disconnected = "DISCONNECTED";
      };

      "module/cpu" = {
        type = "internal/cpu";

        interval = "5";

        format = "<label> ";
        format-padding = padding;
        label = "CPU %percentage%%";
      };

      "module/memory" = {
        type = "internal/memory";

        interval = 5;

        format = "<label>";
        format-padding = padding;

        label = "RAM %used% (%percentage_used%%)";
      };

      "module/time" = {
        type = "internal/date";

        interval = "1.0";

        time = "%a %e %H:%M";
        time-alt = "%Y-%m-%d %H:%M:%S";

        format = "<label>";
        format-padding = padding;

        label = "%time%";
      };

      "module/tray" = {
        type = "internal/tray";
        tray-size = "90%:-4pt";
        tray-spacing = 0;
        tray-padding = padding;
      };
    };
  };
}
