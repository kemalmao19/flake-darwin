{ pkgs, ... }: {

  programs.neovim = {
    enable = true;
    withPython3 = true;
    withNodeJs = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      nord-nvim
    ];
    extraConfig = ''
    '';
  };
  xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };
}
