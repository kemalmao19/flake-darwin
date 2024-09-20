{ pkgs, ... }: {

  programs.neovim =
    let 
      openFile = path: "${builtins.readFile path}";
    in
    {
      enable = true;
      withPython3 = true;
      withNodeJs = true;
      viAlias = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [
        vim-nix
        vim-tmux-navigator

        # bufferline dep 
        vim-bbye 
        nvim-web-devicons


        #misc
        vim-sleuth
        vim-fugitive
        vim-rhubarb
        which-key-nvim
        todo-comments-nvim

        # cmp-nvim dep
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        cmp-cmdline
        cmp_luasnip
        luasnip

        # telescope dependency
        telescope-fzf-native-nvim
        telescope-ui-select-nvim
        plenary-nvim

        # none ls
        null-ls-nvim

        {
          plugin = friendly-snippets;
          type = "lua";
          config = ''
          require('luasnip.loaders.from_vscode').lazy_load()
          '';
        }
        {
           plugin = neoscroll-nvim;
           type = "lua";
           config = openFile ./config/plugins/smooth-scroll.lua;
        } 
        {
          plugin = gitsigns-nvim;
          type = "lua";
          config = openFile ./config/plugins/gitsigns.lua;
        }
        {
          plugin = indent-blankline-nvim;
          type = "lua";
          config = openFile ./config/plugins/indent-blank.lua;
        }
        {
          plugin = nvim-colorizer-lua;
          type = "lua";
          config = ''require("colorizer").setup()'';
        }
        {
          plugin = onedark-nvim;
          type = "lua";
          config = openFile ./config/plugins/colorthemes.lua;
        }
        {
          plugin = nvim-autopairs;
          type = "lua";
          config = openFile ./config/plugins/autopair.lua;
        }
        {
          plugin = nvim-tree-lua;
          type = "lua";
          config = openFile ./config/plugins/nvim-tree.lua;
        }
        {
          plugin = lualine-nvim;
          type = "lua";
          config = openFile ./config/plugins/lualine.lua;
        }
        {
          plugin = comment-nvim;
          type = "lua";
          config = openFile ./config/plugins/comment.lua;
        }
        {
          plugin = bufferline-nvim;
          type = "lua";
          config = openFile ./config/plugins/bufferline.lua;
        }
        {
          plugin = (nvim-treesitter.withPlugins (p: [
            p.tree-sitter-nix
            p.tree-sitter-typescript
            p.tree-sitter-javascript
            p.tree-sitter-vim
            p.tree-sitter-bash
            p.tree-sitter-lua
            p.tree-sitter-python
            p.tree-sitter-json
          ]));
          type = "lua";
          config = openFile ./config/plugins/treesitter.lua;
        }
        {
          plugin = telescope-nvim;
          type = "lua";
          config = openFile ./config/plugins/telescope.lua;
        }
        {
          plugin = alpha-nvim;
          type = "lua";
          config = openFile ./config/plugins/alpha.lua;
        }
        {
          plugin = lazy-lsp-nvim;
          type = "lua";
          config = openFile ./config/plugins/lazy-lsp.lua;
        }
        {
          plugin = nvim-cmp;
          type = "lua";
          config = openFile ./config/plugins/autocomplete.lua;
        }
        {
          plugin = none-ls-nvim;
          type = "lua";
          config = openFile ./config/plugins/none-ls.lua;
        }
        {
          plugin = codeium-nvim;
          type = "lua";
          config = openFile ./config/plugins/codeium.lua;
        }
      ];

      # extraConfig = ''
      #   luafile ${openFile ./config/core/options.lua}
      #   luafile ${openFile ./config/core/keymaps.lua}
      #   luafile ${openFile ./config/core/snippet.lua}
      #   luafile ${openFile ./config/core/misc.lua}
      # '';

      extraConfig = ''
        luafile ~/flake-darwin/modules/home-manager/packages/neovim/config/core/options.lua
        luafile ~/flake-darwin/modules/home-manager/packages/neovim/config/core/keymaps.lua
        luafile ~/flake-darwin/modules/home-manager/packages/neovim/config/core/snippet.lua
        luafile ~/flake-darwin/modules/home-manager/packages/neovim/config/core/misc.lua
      '';
    };
  # easy mode
  # xdg.configFile.nvim = {
  #   source = ./config;
  #   recursive = true;
  # };
}
