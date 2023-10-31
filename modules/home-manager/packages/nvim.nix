{ pkgs, inputs, ... }: {

  nixpkgs = {
    overlays = [
      (final: prev: {
        vimPlugins = prev.vimPlugins // {
          own-onedark-nvim = prev.vimUtils.buildVimPlugin {
            name = "onedark";
            src = inputs.plugin-onedark;
          };
        };
      })
    ];
  };

  programs.neovim = {
    enable = true;
    withPython3 = true;
    # extraPython3Packages = pyPkgs: with pyPkgs; [ python-lsp-server ];
    withNodeJs = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      vim-css-color
      vim-html-template-literals
      vim-javascript
      vim-nix
      vim-nerdtree-syntax-highlight
      vim-python-pep8-indent

      vim-vsnip
      cmp-vsnip
      {
        plugin = cmp-nvim-lsp;
        type = "lua";
        config = ''
                    -- Set up lspconfig.
                     local capabilities = require('cmp_nvim_lsp').default_capabilities()
                    -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
                    require('lspconfig')['pyright'].setup {
                    capabilities = capabilities
          }
        '';
      }
      
      {
        plugin = nvim-cmp;
        type = "lua";
        config = ''
        local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
    capabilities = capabilities
  }
        '';
      }
      {
        plugin = lazy-lsp-nvim;
        type = "lua";
        config = ''
        require("lazy-lsp").setup {
          excluded_servers = {
            "diagnosticls", "efm", "jedi_language_server", "pylsp",
          },
        -- Alternatively specify preferred servers for a filetype (others will be ignored).
        preferred_servers = {
          python = { "pyright" },
          html = {"html"},
          css = {"emmet_ls"},
          javascript = {"eslint"}
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

        }
        '';
      }

      {
        plugin = comment-nvim;
        type = "lua";
        config = ''
          require('Comment').setup()
        '';
      }

      {
        plugin = nvim-autopairs;
        type = "lua";
        config = ''require("nvim-autopairs").setup {}'';
      } 

      vim-airline
      {
        plugin = vim-airline-themes;
        config = ''
          let g:airline_symbols = {'s1':''}
          let g:airline_section_error = ""
          let g:airline_powerline_fonts = 1
          let g:airline#extensions#tabline#enabled = 1
          let g:airline_section_warning = ""
          let g:airline_section_c = "%<%t%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#%#__accent_bold#%{airline#util#wrap(airline#extensions#coc#get_status(),0)}%#__restore__#%#__accent_bold#%#__restore__#"
          if !exists('g:airline_symbols')
            let g:airline_symbols = {}
          endif
        '';
      }
      {
        plugin = ctrlp-vim;
        config = ''
          let g:ctrlp_custom_ignore = '\v\.(npy|jpg|pyc|so|dll)$'
          let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
        '';
      }

      {
        plugin = nerdtree;
        config =
          ''let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree'';
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
      
      let g:NERDTreeDirArrowExpandable = '▸'
      let g:NERDTreeDirArrowCollapsible = '▾'
      map <C-n> :NERDTreeToggle<CR>

      set encoding=utf-8
      set clipboard=unnamed
      set nu
      set cursorline
      set scrolloff=5
    '';
  };
}
