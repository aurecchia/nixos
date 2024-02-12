{ config, lib, pkgs, vars, ... }:

let
  mod = "Mod4";
  dmenuOpts = "-fn \"JetBrains Mono NL-11:Bold\" -nb \"#000000\"";

  # Workspaces
  ws1 = "1: dev";
  ws2 = "2: term";
  ws3 = "3: www";
  ws4 = "4: slack";
  ws5 = "5";
  ws6 = "6";
  ws7 = "7";
  ws8 = "8";
  ws9 = "9";
  ws10 = "10: spotify";

  # Outputs
  center_screen = "DisplayPort-2";
  left_screen = "HDMI-A-0";

  right_screen = "DisplayPort-1";

  # Modes
  mode_resize = "Resize";
  mode_system = "System lock (l), poweroff (p), reboot (r), suspend (s), hibernate (h)";
in {

  home.packages = with pkgs; [
    i3status
  ];

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
          separator_color = "#dededeff";
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
          foreground = "#DEDEDEFF";
        };
        urgency_low = {
          background = "##444E5BFF";
          frame_color = "#DEDEDEFF";
        };
        urgency_normal = {
          background = "#3C4D63FF";
          frame_color = "#DEDEDEFF";
        };
        urgency_critical = {
          background = "#A01919FF";
          foreground = "#FFFFFFFF";
          frame_color = "#FFFFFFFF";
          fullscreen = "show";
          timeout = 0;
        };
      };
    };
    picom = {
      enable = true;
      fade = true;
      fadeDelta = 3;
      # inactiveDim = "0.2";
      shadow = true;
      shadowOffsets = [ (-4) (-4) ];
      shadowOpacity = 0.4;
      shadowExclude = [
        # unknown windows
        "! name~=''"
        # shaped windows
        "bounding_shaped && !rounded_corners"
        # no shadow on i3 frames
        "class_g = 'i3-frame'"
        # hidden windows
        "_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
        # stacked / tabbed windows
        "_NET_WM_STATE@[0]:a = '_NET_WM_STATE@_MAXIMIZED_VERT'"
        "_NET_WM_STATE@[0]:a = '_NET_WM_STATE@_MAXIMIZED_HORZ'"
        "_GTK_FRAME_EXTENTS@:c"
        # notifications
        "_NET_WM_WINDOW_TYPE@:32a *= '_NET_WM_WINDOW_TYPE_NOTIFICATION'"
        # Mozilla fixes
        "(class_g = 'Firefox' || class_g = 'Thunderbird') && (window_type = 'utility' || window_type = 'popup_menu') && argb"
      ];
      vSync = true;
      settings = {
        # mark-wmwin-focused = true;
        # mark-ovredir-focused = true;
        # detect-rounded-corners = true;
        # detect-client-opacity = true;
        # detect-transient = true;
        # glx-no-stencil = true
        # glx-no-rebind-pixmap = true;
        # use-damage = true;
        "shadow-radius" = 4;
        # xinerama-shadow-crop = true;
        # xrender-sync-fence = true;
        # focus-exclude = [
        #   "name = 'Picture-in-Picture'",
        #   "_NET_WM_STATE@:32a *= '_NET_WM_STATE_FULLSCREEN'"
        # ];
      };
    };
    redshift = {
      enable = true;
      tray = true;
      provider = "geoclue2";
      settings.redshift.adjustment-method = "randr";
    };
    polybar = 
    let
      fg = "#fefefe";
      bg = "#202020";
    in {
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
  };

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

        focus = {
          followMouse = false;
          forceWrapping = false;
          mouseWarping = true;
        };

        bars = [];

        gaps = {
          outer = 0;
          inner = 6;
        };

        window = {
          titlebar = false;
          border = 2;
          hideEdgeBorders = "smart";
          commands = [
            { criteria = { window_role = "pop-up"; }; command = "floating enable"; }
            { criteria = { window_role = "task_dialog"; }; command = "floating enable"; }
            { criteria = { title = "Preferences$"; }; command = "floating enable"; }
            { criteria = { title = "Gpick"; }; command = "floating enable"; }
            { criteria = { title = "Master Password"; }; command = "floating enable"; }

            # Fix floating popups in Jetbrains products
            # TODO: How to translate this?
            #{ criteria = { class = "^jetbrains-.+"][window_type=dialog] focus
            { criteria = { instance = "sun-awt-X11-XWindowPeer"; }; command = "border pixel 0"; }
            { criteria = { instance = "sun-awt-X11-XWindowPeer"; }; command = "floating enable"; }
            { criteria = { class = "jetbrains-toolbox"; }; command = "floating enable"; }
          ];
        };

       floating = {
         modifier = "${mod}";
       };

        workspaceOutputAssign = [
          { workspace = ws1; output = center_screen; }
          { workspace = ws2; output = center_screen; }
          { workspace = ws3; output = center_screen; }
          { workspace = ws4; output = left_screen; }
          { workspace = ws5; output = center_screen; }
        ];

        modes = {
          "${mode_resize}" = {
            j = "exec \"~/repos/i3-resizer/i3-resizer.py down\"";
            h = "exec \"~/repos/i3-resizer/i3-resizer.py left\"";
            k = "exec \"~/repos/i3-resizer/i3-resizer.py up\"";
            l = "exec \"~/repos/i3-resizer/i3-resizer.py right\"";

            Escape = "mode default";
          };

          "${mode_system}" = {
            l = "exec --no-startup-id nop";
            p = "exec --no-startup-id systemctl poweroff";
            r = "exec --no-startup-id systemctl reboot";
            s = "mode default; exec --no-startup-id systemctl suspend";
            h = "mode default; exec --no-startup-id systemctl hibernate";

            Return = "mode default";
            Escape = "mode default";
          };
        };

        keybindings = {
          "${mod}+q" = "kill";
          "${mod}+Shift+r" = "restart";

          # Launchers
          "${mod}+space" = "exec rofi -show run";
          "${mod}+Return" = "exec rofi -show drun -show-icons";
          "${mod}+b" = "bar mode toggle";
          "${mod}+c" = "exec find ~/.scripts -executable -type f | dmenu ${dmenuOpts} | /bin/sh &";
          "${mod}+e" = "exec emoji-picker";
          "${mod}+f" = "exec thunar";
          #"${mod}+g" = "exec ~/.scripts/i3-wm-scripts/nextfind.py ${dmenuOpts} -l 10";
          "${mod}+t" = "exec kitty";
          "${mod}+w" = "exec firefox-dev";

          # change focus
          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";

          # move focused window
          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+l" = "move right";

          # Splits
          "${mod}+s" = "split toggle";

          "${mod}+F11" = "fullscreen toggle";

          # Layout
          "${mod}+Shift+w" = "layout tabbed";
          "${mod}+Shift+s" = "layout stacking";
          "${mod}+Shift+e" = "layout toggle split";
          "${mod}+Shift+space" = "floating toggle";

          # switch to workspace
          "${mod}+1" = "workspace ${ws1}";
          "${mod}+2" = "workspace ${ws2}";
          "${mod}+3" = "workspace ${ws3}";
          "${mod}+4" = "workspace ${ws4}";
          "${mod}+5" = "workspace ${ws5}";
          "${mod}+6" = "workspace ${ws6}";
          "${mod}+7" = "workspace ${ws7}";
          "${mod}+8" = "workspace ${ws8}";
          "${mod}+9" = "workspace ${ws9}";
          "${mod}+0" = "workspace ${ws10}";
          "${mod}+n" = "workspace next_on_output";
          "${mod}+p" = "workspace prev_on_output";

          # move focused container to workspace
          "${mod}+Shift+1" = "move container to workspace ${ws1}";
          "${mod}+Shift+2" = "move container to workspace ${ws2}";
          "${mod}+Shift+3" = "move container to workspace ${ws3}";
          "${mod}+Shift+4" = "move container to workspace ${ws4}";
          "${mod}+Shift+5" = "move container to workspace ${ws5}";
          "${mod}+Shift+6" = "move container to workspace ${ws6}";
          "${mod}+Shift+7" = "move container to workspace ${ws7}";
          "${mod}+Shift+8" = "move container to workspace ${ws8}";
          "${mod}+Shift+9" = "move container to workspace ${ws9}";
          "${mod}+Shift+0" = "move container to workspace ${ws10}";
          "${mod}+Shift+n" = "move container to workspace next_on_output";
          "${mod}+Shift+p" = "move container to workspace prev_on_output";

          # modes
          "${mod}+r" = "mode \"${mode_resize}\"";
          "${mod}+Shift+q" = "mode \"${mode_system}\"";
        };
      };

      extraConfig = builtins.readFile ./config;
    };

    initExtra = ''
      xset r rate 160 60
      hsetroot -solid #336698
    '';
  };
}

