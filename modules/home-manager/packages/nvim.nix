{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    withPython3 = true;
    extraPython3Packages = pyPkgs: with pyPkgs; [ python-language-server ];
    withNodeJs = true;
    plugins = with pkgs.vimPlugins; [
      neovim-sensible
      nvim-surround
      nvim-treesitter
      vim-nix
      { plugin = vim-startify;
        config = "let g:startify_change_to_vcs_root = 0";
      }

      vim-airline
      {
          plugin = vim-airline-themes;
          config = ''
            let g:airline_themes='wombat'
          '';
      }

      {
        plugin = dracula-vim;
        config = ''
          syntax enable
          colorscheme dracula
        '';
      }
    ];

    extraConfig = ''
      set cursorline
      set scrolloff=5
    '';
  };
}