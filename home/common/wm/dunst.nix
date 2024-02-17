{ pkgs, ... }:
let 
  colors = {
    fg = "#dedede";
    separator =  "#dedede";
    urgency_low_bg = "#444e5b";
    urgency_low_frame = "#dedede";
    urgency_normal_bg = "#3c4d63";
    urgency_normal_frame_col = "#dededeff";
    urgency_critical_bg = "#a01919ff";
    urgency_critical_fg = "#ffffffff";
    urgency_critical_frame = "#ffffffff";
  };
in {
  services = {
    dunst = {
      enable = true;
      settings = {
        global = {
          follow = "keyboard";
          width = "(0, 500)";
          height = 100;
          offset = "10x10";
          separator_height = 1;
          frame_width = 2;
          separator_color = colors.separator;
          font = "JetBrains Mono 10";
          format = ''
            <b>%s</b>
            %b'';
          vertical_alignment = "top";
          show_age_threshold = "5m";
          icon_position = "left";
          max_icon_size = 60;
          # icon_path = "${pkgs.zafiro-icons}/share/icons/Zafiro-icons";
          enable_recursive_icon_lookup = "true";
          dmenu = "${pkgs.rofi}/bin/rofi -dmenu -p dunst";
          mouse_left_click = "close_current";
          mouse_middle_click = "context";
          mouse_right_click = "do_action";
          fullscreen = "pushback";
          timeout = "30s";
          startup_notification = false;
          markup = "full";
          foreground = colors.fg;
        };
        urgency_low = {
          background = colors.urgency_low_bg;
          frame_color = colors.urgency_low_frame;
        };
        urgency_normal = {
          background = colors.urgency_normal_bg;
          frame_color = colors.urgency_normal_frame_col;
        };
        urgency_critical = {
          background = colors.urgency_critical_bg;
          foreground = colors.urgency_critical_fg;
          frame_color = colors.urgency_critical_frame;
          fullscreen = "show";
          timeout = 0;
        };
      };
    };
  };
}
