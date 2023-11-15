{ pkgs, ... }: {

  programs.neovim = {
    enable = true;
    withPython3 = true;
    withNodeJs = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix

      catppuccin-nvim
      indentLine

      nvim-web-devicons
      cmp-nvim-lsp
      # {
      #   plugin=;
      #   type="lua";
      #   config=''

      #   ''
      # }
      {
        plugin=lspkind-nvim;
        config=''
        luafile ~/darwin/modules/home-manager/packages/neovim/lua/lspkind.lua
        ''
      }
      {
        plugin=nvim-cmp;
        config=''
        luafile ~/darwin/modules/home-manager/packages/neovim/lua/cmp.lua
        '';
      }

      {
        plugin=lazy-lsp-nvim;
        type= "lua";
        config=''
        require("lazy-lsp").setup({
          excluded_servers = {
            "ccls",
            "zk",
            "denols",
          },
          default_config = {
            flags = {
              debounce_text_changes = 150,
            },
            capabilities = capabilities,
          },
          configs = {
            lua_ls = {
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                },
              },
            },
          },
        })
        '';
      }

      {
        plugin = nvim-treesitter;
        type = "lua";
        config = ''
        require('nvim-treesitter.configs').setup {
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        }
        '';
      }

      { 
        plugin = nvim-tree-lua;
        type = "lua";
        config = ''require'nvim-tree'.setup{}'';
      }

    ];
    extraConfig = ''
      luafile ~/darwin/modules/home-manager/packages/neovim/lua/settings.lua
      
      colorscheme catppuccin
      set nowrap
      set nobackup
      set nowritebackup
      set noerrorbells
      set noswapfile
      map ; :
    '';
  };
}


# {  lib, config, pkgs, ... }:
# with lib;
# let
#     cfg = config.modules.nvim;
#     # Source my theme
#     jabuti-nvim = pkgs.vimUtils.buildVimPlugin {
#         name = "jabuti-nvim";
#         src = pkgs.fetchFromGitHub {
#             owner = "jabuti-theme";
#             repo = "jabuti-nvim";
#             rev = "17f1b94cbf1871a89cdc264e4a8a2b3b4f7c76d2";
#             sha256 = "sha256-iPjwx/rTd98LUPK1MUfqKXZhQ5NmKx/rN8RX1PIuDFA=";
#         };
#     };
# in {
#     options.modules.nvim = { enable = mkEnableOption "nvim"; };
#     config = mkIf cfg.enable {

#         home.file.".config/nvim/settings.lua".source = ./init.lua;
        
#         home.packages = with pkgs; [
#             rnix-lsp nixfmt # Nix
#             sumneko-lua-language-server stylua # Lua
#         ];

#         programs.zsh = {
#             initExtra = ''
#                 export EDITOR="nvim"
#             '';

#             shellAliases = {
#                 v = "nvim -i NONE";
#                 nvim = "nvim -i NONE";
#             };
#         };

#         programs.neovim = {
#             enable = true;
#             plugins = with pkgs.vimPlugins; [ 
#                 vim-nix
#                 plenary-nvim
#                 {
#                     plugin = zk-nvim;
#                     config = "require('zk').setup()";
#                 }
#                 {
#                     plugin = jabuti-nvim;
#                     config = "colorscheme jabuti";
#                 }
#                 {
#                     plugin = impatient-nvim;
#                     config = "lua require('impatient')";
#                 }
#                 {
#                     plugin = lualine-nvim;
#                     config = "lua require('lualine').setup()";
#                 }
#                 {
#                     plugin = telescope-nvim;
#                     config = "lua require('telescope').setup()";
#                 }
#                 {
#                     plugin = indent-blankline-nvim;
#                     config = "lua require('indent_blankline').setup()";
#                 }
#                 {
#                     plugin = nvim-lspconfig;
#                     config = ''
#                         lua << EOF
#                         require('lspconfig').rust_analyzer.setup{}
#                         require('lspconfig').sumneko_lua.setup{}
#                         require('lspconfig').rnix.setup{}
#                         require('lspconfig').zk.setup{}
#                         EOF
#                     '';
#                 }
#                 {
#                     plugin = nvim-treesitter;
#                     config = ''
#                     lua << EOF
#                     require('nvim-treesitter.configs').setup {
#                         highlight = {
#                             enable = true,
#                             additional_vim_regex_highlighting = false,
#                         },
#                     }
#                     EOF
#                     '';
#                 }
#             ];

#             extraConfig = ''
#                 luafile ~/.config/nvim/settings.lua
#             '';
#         };
#     };
# }