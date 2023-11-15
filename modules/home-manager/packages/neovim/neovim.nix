{ pkgs, ... }: {

  programs.neovim = {
    enable = true;
    withPython3 = true;
    withNodeJs = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [

      

    ];
    extraConfig = ''
      luaFile ./lua/settings.lua
    '';
  };
}
