{ pkgs, ... }: {

  programs.neovim = let openFile = path: "${builtins.readFile path}";
  in {
    enable = true;
    withPython3 = true;
    withNodeJs = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      nvim-web-devicons
      vim-tmux-navigator
      vim-sleuth
      vim-fugitive
      vim-rhubarb
      which-key-nvim
      todo-comments-nvim
      gitsigns-nvim
      indent-blankline-nvim
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
      # {
      #   plugin = none-ls-nvim;
      #   type = "lua";
      #   config = openFile ./config/lua2/plugins/none-ls.lua;
      # }
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
      cmp_luasnip
      luasnip
      {
        plugin = nvim-cmp;
        type = "lua";
        config = openFile ./config/plugins/autocomplete.lua;
      }
    ];

    # extraConfig = ''
    # luafile ${builtins.readFile ./config/core/options.lua}
    # luafile ${builtins.readFile ./config/core/keymaps.lua}
    # luafile ${builtins.readFile ./config/core/snippet.lua}
    # luafile ${builtins.readFile ./config/core/misc.lua}
    # '';

    extraConfig = ''
      luafile ~/flake-darwin/modules/home-manager/packages/neovim/config/core/options.lua
      luafile ~/flake-darwin/modules/home-manager/packages/neovim/config/core/keymaps.lua
      luafile ~/flake-darwin/modules/home-manager/packages/neovim/config/core/snippet.lua
      luafile ~/flake-darwin/modules/home-manager/packages/neovim/config/core/misc.lua
    '';
  };
  # luafile ~/flake-darwin/modules/home-manager/packages/neovim/config/lua2/core/keymaps.lua
  # easy mode
  # xdg.configFile.nvim = {
  #   source = ./config;
  #   recursive = true;
  # };
}
