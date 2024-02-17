{ ... }:
 let
  fg = "#fefefe";
  bg = "#202020";
in
{
  services.polybar = {
    enable = false;
    script = "polybar -q -r top &";

    config = {
      "global/wm" = {
        dpi = 140;
        format-padding = 2;
      };

      "bar/top" = {
        bottom = false;
        width = "100%";
        height = 32;

        font-0 = "JetBrains Mono:size=14;5";

        foreground = fg;
        background = bg;
        border-bottom-size = 2;
        border-bottom-color = "#000000";

        modules-left = "i3 title";
        modules-right = "memory cpu network time";
      };

      "module/cpu" = {
        type = "internal/cpu";

        interval = "0.5";

        format = " <label>";
        # format-foreground = "#ffffff";
        # format-background = "#000000";

        label = "CPU %percentage%%";
      };

      "module/time" = {
        type = "internal/date";

        interval = "1.0";

        time = "%Y-%m-%d% %H:%M:%S";
        time-alt = "%H:%M:%S";

        format = "<label>";

        label = "%time%";
      };

      "module/i3" = {
        type = "internal/i3";
        pin-workspaces = false;
        # strip-wsnumbers = true;
        format = "<label-state> <label-mode>";
        # format-background = tertiary;

        ws-icon-0 = "1:";
        ws-icon-1 = "2:";
        ws-icon-2 = "3:";
        ws-icon-3 = "4:";
        ws-icon-4 = "5:";
        ws-icon-5 = "6:";
        ws-icon-6 = "7:";
        ws-icon-7 = "8:";
        ws-icon-8 = "9:";
        ws-icon-9 = "10:";

        label-mode = "%mode%";
        label-mode-padding = 1;

        label-unfocused = "%icon%";
        # label-unfocused-foreground = quinternary;
        label-unfocused-padding = 1;

        label-focused = "%index% %icon%";
        label-focused-font = 2;
        # label-focused-foreground = secondary;
        label-focused-padding = 1;

        label-visible = "%icon%";
        label-visible-padding = 1;

        label-urgent = "%index%";
        # label-urgent-foreground = urgency;
        label-urgent-padding = 1;

        label-separator = "";
      };


      "module/title" = {
        type = "internal/xwindow";
        format = "<label>";
        # format-foreground = secondary;
        label = "%title%";
        label-maxlen = 70;
      };

      "module/memory" = {
        type = "internal/memory";
     
        interval = 3;
     
        format = " <label>";
        # format-background = tertiary;
        # format-foreground = secondary;
        format-padding = 1;
     
        label = "RAM %percentage_used%%";
      };
     
      "module/network" = {
        type = "internal/network";

        # TODO: pick this up automatically
        interface = "wlp6s0";
     
        interval = "1.0";
     
        accumulate-stats = true;
        unknown-as-up = true;
     
        format-connected = "<label-connected>";
     
        format-disconnected = "<label-disconnected>";
     
        label-connected = "%signal% at %essid% (%local_ip% / %local_ip6%)";
        label-disconnected = "DISCONNECTED";
      };
    };
  };
}
