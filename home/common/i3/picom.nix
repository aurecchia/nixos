{ pkgs, ... }:
{
  services.picom = {
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
}
