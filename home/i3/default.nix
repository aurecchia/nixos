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
          offset = "0x24";
          separator_height = 4;
          frame_width = 0;
          separator_color = "#00000000";
          font = "Iosevka Term 10";
          format = ''
            <b>%s</b>
            %b'';
          vertical_alignment = "top";
          show_age_threshold = "5m";
          icon_position = "left";
          max_icon_size = 60;
          icon_path = "${pkgs.zafiro-icons}/share/icons/Zafiro-icons";
          enable_recursive_icon_lookup = "true";
          dmenu = "${pkgs.rofi}/bin/rofi -dmenu -p dunst";
          mouse_left_click = "close_current";
          mouse_middle_click = "context";
          mouse_right_click = "do_action";
          fullscreen = "pushback";
          timeout = "30s";
          startup_notification = false;
          markup = "full";
          foreground = "#eceff4";
        };
        urgency_low = { background = "#4c566acc"; };
        urgency_normal = { background = "#5e81accc"; };
        urgency_critical = {
          background = "#bf616acc";
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

        window = {
          hideEdgeBorders = "both";
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

    initExtra = "xset r rate 160 60";
  };
}

