{pkgs, ... }: {
  #YABAI Window Manager
  services.yabai = {
    enable = true;
    config = {
          focus_follows_mouse = "autoraise";
          # mouse_follows_focus = "off";
          window_placement    = "second_child";
          window_opacity      = "off";
          top_padding         = 10;
          bottom_padding      = 10;
          left_padding        = 10;
          right_padding       = 10;
          window_gap          = 10;
        };
    extraConfig = ''
      yabai -m rule --add app='System Preferences' manage=off
    '';
    # enableScriptingAddition = true;
  };
}