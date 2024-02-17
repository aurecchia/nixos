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

  xsession.windowManager.i3 = {
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
}

