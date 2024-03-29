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
      tokyonight-nvim
      dracula-nvim
      nord-nvim
      indentLine
      vim-reasonml

      nvim-web-devicons
      cmp-nvim-lsp

      vim-airline
      vim-airline-themes

      vim-vsnip
      cmp-vsnip
      {
        plugin=lspkind-nvim;
        config=''
        luafile ~/darwin/modules/home-manager/packages/neovim/lua/lspkind.lua
        '';
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
      

      map <C-n> :NvimTreeToggle<CR>
      set laststatus=2
      let g:airline#extensions#tabline#enabled = 1
      let g:airline_powerline_fonts = 1
      let g:airline_statusline_ontop=0
      let g:airline_theme='badwolf'

      let g:airline_extensions = ['esy', 'reason']
        let g:reasonml_project_airline=1
        let g:reasonml_syntastic_airline=1
        let g:reasonml_clean_project_airline=1
        let g:airline#extensions#whitespace#enabled = 0
        let g:airline_powerline_fonts = 1
        let g:airline_skip_empty_sections = 1

        autocmd FileType reason map <buffer> <D-C> :ReasonPrettyPrint<Cr>

      let g:airline#extensions#tabline#formatter = 'default'
      " navegação entre os buffers
      " nnoremap <M-Right> :bn<cr>
      " nnoremap <M-Left> :bp<cr>
      " nnoremap <c-x> :bp \|bd #<cr>

      colorscheme nord
      set nowrap
      set nobackup
      set nowritebackup
      set noerrorbells
      set noswapfile
      map ; :
    '';
  };
}
