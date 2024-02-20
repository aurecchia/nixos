{ pkgs, ... }:
 let
  fg = "#fefefe";
  bg = "#202020";
in
{
  services.polybar = {
    enable = true;

    package = pkgs.polybar.override {
      i3Support = true;
    };

    script = ''
      polybar -q -r center &
      polybar -q -r left &
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
        height = 32;

        font-0 = "JetBrains Mono Semibold:size=15;5";

        border-bottom-size = 2;
        border-bottom-color = "#000000";

        modules-left = "i3";
        modules-right = "memory cpu time tray";
      };

      "bar/left" = {
        monitor = "HDMI-A-0";
        height = 32;

        font-0 = "JetBrains Mono Semibold:size=15;5";

        border-bottom-size = 2;
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
        label-mode-padding = 1;

        label-focused = "%name%";
        label-focused-foreground = "#ffffff";
        label-focused-background = "#005F87";
        label-focused-padding = 1;

        label-unfocused = "%name%";
        label-unfocused-foreground = "#585858";
        label-unfocused-background = "#2a2a2a";
        label-unfocused-padding = 1;

        label-visible = "%name%";
        label-visible-foreground = "#585858";
        label-visible-background = "#2a2a2a";
        label-visible-padding = 1;

        label-urgent = "%name%";
        label-urgent-foreground = "#ffffff";
        label-urgent-background = "#87005F";
        label-urgent-padding = 1;

        label-separator = " ";
        label-separator-background = "#000000";
      };

      "module/title" = {
        type = "internal/xwindow";
        format = "<label>";
        format-padding = 1;
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
        format-padding = 1;
        label = "CPU %percentage%%";
      };

      "module/memory" = {
        type = "internal/memory";

        interval = 5;

        format = "<label>";
        format-padding = 1;

        label = "RAM %used% (%percentage_used%%)";
      };

      "module/time" = {
        type = "internal/date";

        interval = "1.0";

        time = "%Y-%m-%d %H:%M:%S";
        time-alt = "%H:%M:%S";

        format = "<label>";
        format-pading = 1;

        label = "%time%";
      };

      "module/tray" = {
        type = "internal/tray";
        format-pading = 1;
      };
    };
  };
}
