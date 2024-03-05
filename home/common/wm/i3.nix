{ config, lib, pkgs, vars, ... }:

let
  mod = "Mod4";
  dmenuOpts = "-fn \"JetBrains Mono NL-11:Bold\" -nb \"#000000\"";

  # Workspaces
  ws1 = "1";
  ws2 = "2";
  ws3 = "3";
  ws4 = "4";
  ws5 = "5";
  ws6 = "6";
  ws7 = "7";
  ws8 = "8";
  ws9 = "9";
  ws10 = "10";

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
    i3wsr
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

      # gaps = {
      #   outer = 0;
      #   inner = 6;
      # };

      colors = {
        background = "#151515";
        focused = {
          border = "$focused_border";
          background = "$focused_bg";
          text = "$focused_fg";
          indicator = "$focused_indicator";
          childBorder = "$focused_border";
        };
        focusedInactive = {
          background = "$inactive_bg";
          text = "$inactive_fg";
          border = "$inactive_border";
          childBorder = "$inactive_border";
          indicator = "$inactive_border";
        };
        unfocused = {
          background = "$unfocused_bg";
          text = "$unfocused_fg";
          border = "$unfocused_border";
          childBorder = "$unfocused_border";
          indicator = "$unfocused_border";
        };
        urgent = {
          background = "$urgent_bg";
          text = "$urgent_fg";
          border = "$urgent_border";
          childBorder = "$urgent_border";
          indicator = "$urgent_border";
        };
        placeholder = {
          background = "$placeholder_bg";
          text = "$placeholder_fg";
          border = "$placeholder_border";
          childBorder = "$placeholder_border";
          indicator = "$placeholder_border";
        };
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
        "${mod}+t" = "exec \$TERMINAL";
        "${mod}+w" = "exec \$BROWSER";

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
        "${mod}+1" = "workspace number ${ws1}";
        "${mod}+2" = "workspace number ${ws2}";
        "${mod}+3" = "workspace number ${ws3}";
        "${mod}+4" = "workspace number ${ws4}";
        "${mod}+5" = "workspace number ${ws5}";
        "${mod}+6" = "workspace number ${ws6}";
        "${mod}+7" = "workspace number ${ws7}";
        "${mod}+8" = "workspace number ${ws8}";
        "${mod}+9" = "workspace number ${ws9}";
        "${mod}+0" = "workspace number ${ws10}";
        "${mod}+n" = "workspace next_on_output";
        "${mod}+p" = "workspace prev_on_output";

        # move focused container to workspace
        "${mod}+Shift+1" = "move container to workspace number ${ws1}";
        "${mod}+Shift+2" = "move container to workspace number ${ws2}";
        "${mod}+Shift+3" = "move container to workspace number ${ws3}";
        "${mod}+Shift+4" = "move container to workspace number ${ws4}";
        "${mod}+Shift+5" = "move container to workspace number ${ws5}";
        "${mod}+Shift+6" = "move container to workspace number ${ws6}";
        "${mod}+Shift+7" = "move container to workspace number ${ws7}";
        "${mod}+Shift+8" = "move container to workspace number ${ws8}";
        "${mod}+Shift+9" = "move container to workspace number ${ws9}";
        "${mod}+Shift+0" = "move container to workspace number ${ws10}";
        "${mod}+Shift+n" = "move container to workspace next_on_output";
        "${mod}+Shift+p" = "move container to workspace prev_on_output";

        # modes
        "${mod}+r" = "mode \"${mode_resize}\"";
        "${mod}+Shift+q" = "mode \"${mode_system}\"";

        # other
        "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume 9 +5%";
        "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume 9 -5%";
        "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute 0 toggle";

        "XF86MonBrightnessUp" = "exec \"xbacklight -inc 10\"";
        "XF86MonBrightnessDown" = "exec \"xbacklight -dec 10\"";

        "XF86AudioPlay" = "exec playerctl play";
        "XF86AudioPause" = "exec playerctl pause";
        "XF86AudioNext" = "exec playerctl next";
        "XF86AudioPrev" = "exec playerctl previous";

        "--release Print" = "exec mate-screenshot --interactive";
        "--release Shift+Print" = "exec mate-screenshot --area";
      };

      startup = [
        { command = "i3wsr"; always = true; notification = false; }
        { command = "systemctl --user restart polybar"; always = true; notification = false; }
      ];
    };

    extraConfig = ''
      set_from_resource $bar_background      i3.background         #101010
      set_from_resource $bar_statusline      i3.foreground         #ffffff
      set_from_resource $bar_separator       i3.barDimmed          #666666

      set_from_resource $focused_bg          i3.focusedBg          #005F87
      set_from_resource $focused_fg          i3.focusedFg          #ffffff
      set_from_resource $focused_border      i3.focusedBorder      #005F87
      set_from_resource $focused_indicator   i3.indicator          #007FB4

      set_from_resource $inactive_bg         i3.inactiveBg         #2a2a2a
      set_from_resource $inactive_fg         i3.inactiveFg         #585858
      set_from_resource $inactive_border     i3.inactiveBorder     #2a2a2a

      set_from_resource $unfocused_bg        i3.unfocusedBg        #2a2a2a
      set_from_resource $unfocused_fg        i3.unfocusedFg        #585858
      set_from_resource $unfocused_border    i3.unfocusedBorder    #000000

      set_from_resource $urgent_bg           i3.urgentBg           #900000
      set_from_resource $urgent_fg           i3.urgentFg           #ffffff
      set_from_resource $urgent_border       i3.urgentBorder       #2f343a

      set_from_resource $placeholder_bg      i3.placeholderBg      #0c0c0c
      set_from_resource $placeholder_fg      i3.placeholderFg      #ffffff
      set_from_resource $placeholder_border  i3.placeholderBorder  #0c0c0c
    '';
  };
}

