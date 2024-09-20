{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    userSettings = {
      "files.autoSave" = "off";
      "editor.tabSize" = 2;
      "workbench.colorTheme" = "GitHub Dark Dimmed";
      "editor.fontFamily" =
        "FiraCode Nerd Font, Monaco, 'Courier New', monospace";
      "editor.fontLigatures" = true;
      "editor.minimap.enabled" = false;
      "search.exclude" = {
        "**/node_modules" = true;
        "**/bower_components" = true;
        "**/env" = true;
        "**/venv" = true;
      };
      "files.watcherExclude" = {
        "**/.git/objects/**" = true;
        "**/.git/subtree-cache/**" = true;
        "**/node_modules/**" = true;
        "**/env/**" = true;
        "**/venv/**" = true;
        "env-*" = true;
      };
      "codeium.enableConfig" = { "*" = true; };
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };
    extensions = with pkgs.vscode-extensions; [
      ms-vscode.live-server
      github.github-vscode-theme
      esbenp.prettier-vscode
    ];
  };

}
