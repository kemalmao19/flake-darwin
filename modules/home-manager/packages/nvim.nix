{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    withPython3 = true;
    extraPython3Packages = pyPkgs: with pyPkgs; [ python-lsp-server ];
    withNodeJs = true;
    plugins = with pkgs.vimPlugins; [
      YouCompleteMe
      neovim-sensible
      nvim-surround
      nvim-treesitter
      vim-nix
      {
        plugin = vim-flake8;
        config = ''
          let python_highlight_all=1
          syntax on
        '';
      }

      {
        plugin = nerdtree;
        config =
          ''let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree'';
      }
      # { plugin = vim-startify;
      #   config = "let g:startify_change_to_vcs_root = 0";
      # }

      vim-airline
      {
        plugin = vim-airline-themes;
        config = ''
          let g:airline_themes='wombat'
        '';
      }

      {
        plugin = catppuccin-nvim;
        config = ''
          syntax enable
          colorscheme catppuccin
        '';
      }
    ];

    extraConfig = ''
      set encoding=utf-8
      set clipboard=unnamed
      set nu
      set cursorline
      set scrolloff=5
    '';
  };
}
