{ pkgs, ... }: {

  programs.neovim = {
    enable = true;
    withPython3 = true;
    withNodeJs = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
    ];
    # extraConfig = ''
    # luafile ~/flake-darwin/modules/home-manager/packages/neovim/config/lua/core/options.lua
    # luafile ~/flake-darwin/modules/home-manager/packages/neovim/config/lua/core/keymaps.lua
    # luafile ~/flake-darwin/modules/home-manager/packages/neovim/config/lua/core/snippet.lua
    # '';
  };
  # easy mode
  xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };
}
