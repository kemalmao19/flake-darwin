-- Utilities for creating configurations
local util = require 'formatter.util'
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
augroup('__formatter__', { clear = true })
autocmd('BufWritePost', {
  group = '__formatter__',
  command = ':FormatWrite',
})

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require('formatter').setup {
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    -- Formatter configurations for filetype "lua" go here
    -- and will be executed in order
    lua = {
      -- stylua
      require('formatter.filetypes.lua').stylua,
      function()
        if util.get_current_buffer_file_name() == 'special.lua' then
          return nil
        end
        return {
          exe = 'stylua',
          args = {
            '--search-parent-directories',
            '--stdin-filepath',
            util.escape_path(util.get_current_buffer_file_path()),
            '--',
            '-',
          },
          stdin = true,
        }
      end,
    },
    -- javascript = {
    --   -- prettierd
    --   function()
    --     return {
    --       exe = 'prettierd',
    --       args = { vim.api.nvim_buf_get_name(0) },
    --       stdin = true,
    --     }
    --   end,
    -- },
    typescriptreact = {
      -- prettier
      function()
        return {
          exe = 'prettierd',
          args = { '--stdin-filepath', vim.api.nvim_buf_get_name(0) },
          stdin = true,
        }
      end,
    },
    typescript = {
      -- prettier
      function()
        return {
          exe = 'prettierd',
          args = { '--stdin-filepath', vim.api.nvim_buf_get_name(0) },
          stdin = true,
        }
      end,
      -- linter
      -- function()
      --   return {
      --     exe = "eslint",
      --     args = {
      --       "--stdin-filename",
      --       vim.api.nvim_buf_get_name(0),
      --       "--fix",
      --       "--cache"
      --     },
      --     stdin = false
      --   }
      -- end
    },
    javascript = {
      -- prettier
      function()
        return {
          exe = 'prettierd',
          args = { '--stdin-filepath', vim.api.nvim_buf_get_name(0) },
          stdin = true,
        }
      end,
    },
    javascriptreact = {
      -- prettier
      function()
        return {
          exe = 'prettier',
          args = { '--stdin-filepath', vim.api.nvim_buf_get_name(0) },
          stdin = true,
        }
      end,
    },
    json = {
      -- prettier
      function()
        return {
          exe = 'prettierd',
          args = { '--stdin-filepath', vim.api.nvim_buf_get_name(0) },
          stdin = true,
        }
      end,
    },

    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ['*'] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require('formatter.filetypes.any').remove_trailing_whitespace,
    },
  },
}
