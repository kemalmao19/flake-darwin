{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    # enableMouse = true;
    # enableSensible = true;
    reverseSplit = true;
    newSession = true;
    customPaneNavigationAndResize = true;

    plugins = with pkgs;
      [
        #tmuxPlugins.catppuccin
        tmuxPlugins.power-theme
        tmuxPlugins.yank
      ];

    extraConfig = ''
      set -g status off

      # COLORS
      bg_color='#282c34'

      # BORDERS COLOR
      set -g pane-border-style "fg=$bg_color bg=$bg_color"
      set -g pane-active-border-style "fg=$bg_color bg=$bg_color"
      set -sg escape-time 10 
    '';
  };
}