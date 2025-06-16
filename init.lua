-- LAZY
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out,                            'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require 'lazy'.setup({
    'nvim-tree/nvim-web-devicons',
    {
      'nvimdev/indentmini.nvim',
      event = { "BufReadPost", "BufNewFile" },
      config = function()
        require 'indentmini'.setup()
        vim.cmd.highlight('IndentLine guifg=#2a2a37')
        vim.cmd.highlight('IndentLineCurrent guifg=#2a2a37')
      end
    },
    {
      'williamboman/mason.nvim',
      cmd = { "Mason", "MasonInstall", "MasonUpdate" },
      config = true
    },
    {
      'lewis6991/gitsigns.nvim',
      event = { "BufReadPost", "BufNewFile" },
      config = true
    },
    {
      'stevearc/conform.nvim',
      event = { "BufReadPost", "BufNewFile" },
      config = {
        format_after_save = {
          lsp_format = "fallback"
        }
      }
    },
    {
      'nvim-treesitter/nvim-treesitter',
      event = { "BufReadPost", "BufNewFile" },
      cmd = { "TSInstall", "TSInstallInfo", "TSModuleInfo" },
      build = ':TSUpdate',
      config = function()
        require 'nvim-treesitter.configs'.setup {
          auto_install = true,
          highlight = {
            enable = true
          }
        }
      end
    },
    {
      'rebelot/kanagawa.nvim',
      lazy = false,
      priority = 1000,
      config = function()
        require 'kanagawa'.setup {
          overrides = function()
            return {
              FloatBorder = { bg = nil },
              Pmenu = { link = 'FloatBorder' },
            }
          end
        }
        vim.cmd('colorscheme kanagawa-dragon')
      end
    },
    {
      'nvim-tree/nvim-tree.lua',
      config = {
        hijack_cursor = true,
        filters = { enable = false }
      }
    },
    {
      'saghen/blink.cmp',
      event = 'InsertEnter',
      version = '1.*',
      dependencies = { 'rafamadriz/friendly-snippets' },
      opts = {
        completion = {
          list = {
            selection = {
              preselect = false
            }
          }
        },
        keymap = {
          ['<CR>'] = { 'accept', 'fallback' },
          ["<Tab>"] = {
            "select_next",
            "snippet_forward",
            "fallback"
          },
          ["<S-Tab>"] = {
            "select_prev",
            "snippet_backward",
            "fallback"
          },
          ['<Up>'] = {},
          ['<Down>'] = {}
        }
      }
    },
    {
      'neovim/nvim-lspconfig',
      event = "User FilePost",
      dependencies = {
        'williamboman/mason-lspconfig.nvim',
        'b0o/schemastore.nvim',
      },
      config = function()
        local l = require 'lspconfig'
        local m = require('blink.cmp').get_lsp_capabilities()
        local c = {
          ['jsonls'] = {
            settings = {
              json = {
                schemas = require 'schemastore'.json.schemas(),
                validate = { enable = true }
              }
            },
            capabilities = m
          },
          ['yamlls'] = {
            settings = {
              yaml = {
                schemaStore = { enable = false, url = '' },
                schemas = require 'schemastore'.yaml.schemas(),
              }
            },
            capabilities = m
          }
        }

        require 'mason-lspconfig'.setup {
          handlers = {
            function(s)
              if c[s] then
                l[s].setup(c[s])
              else
                l[s].setup({ capabilities = m })
              end
            end
          }
        }
      end
    }
  },
  {
    defaults = {
      lazy = true
    },
    performance = {
      rtp = {
        disabled_plugins = {
          'editorconfig',
          'gzip',
          'man',
          'matchit',
          'matchparen',
          'netrwPlugin',
          'osc52',
          'rplugin',
          'shada',
          'spellfile',
          'tarPlugin',
          'tohtml',
          'tutor',
          'zipPlugin'
        }
      }
    }
  })

-- NEOVIM
local g = vim.g
local o = vim.opt
local keymap = vim.api.nvim_set_keymap
local autocmd = vim.api.nvim_create_autocmd

g.mapleader = ' '

o.mouse = 'a'
o.signcolumn = 'yes:1'
o.laststatus = 3
o.timeoutlen = 1000
o.number = true
o.numberwidth = 1
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
o.ignorecase = true
o.smartcase = true
o.termguicolors = true
o.clipboard = 'unnamedplus'

keymap('v', '<C-w>', ':m \'<-2<CR>gv=gv', {})
keymap('v', '<C-s>', ':m \'>+1<CR>gv=gv', {})
keymap('n', '<Leader>q', ':q<CR>', {})
keymap('n', '<Leader>T', ':NvimTreeClose<CR>', {})
keymap('n', '<Leader>t', '', {
  callback = function()
    local t = require 'nvim-tree.api'.tree
    local _ = t.is_visible() and t.focus() or t.open()
  end
})
keymap('', '<Leader>c', '', {
  callback = function()
    local cs = vim.bo.commentstring
    local mcs = vim.pesc(cs):gsub('%%%%s', '(.*)')
    local s, e = vim.fn.line('v'), vim.fn.line('.')
    if s > e then
      s, e = e, s
    end
    local function comment(line)
      return cs:format(line)
    end
    local function uncomment(line)
      return line:find(mcs) ~= nil and line:match(mcs) or nil
    end
    local lines = vim.api.nvim_buf_get_lines(0, s - 1, e, false), s, e
    for i, line in ipairs(lines) do
      lines[i] = uncomment(line) or comment(line)
    end
    vim.api.nvim_buf_set_lines(0, s - 1, e, true, lines)
  end
})

function Statusline()
  local m = {
    ['n'] = 'NORMAL',
    ['no'] = 'NORMAL',
    ['v'] = 'VISUAL',
    ['V'] = 'VISUAL LINE',
    [''] = 'VISUAL BLOCK',
    ['s'] = 'SELECT',
    ['S'] = 'SELECT LINE',
    [''] = 'SELECT BLOCK',
    ['i'] = 'INSERT',
    ['ic'] = 'INSERT',
    ['R'] = 'REPLACE',
    ['Rv'] = 'VISUAL REPLACE',
    ['c'] = 'COMMAND',
    ['cv'] = 'VIM EX',
    ['ce'] = 'EX',
    ['r'] = 'PROMPT',
    ['rm'] = 'MOAR',
    ['r?'] = 'CONFIRM',
    ['!'] = 'SHELL',
    ['t'] = 'TERMINAL',
    ['nt'] = 'TERMINAL',
  }
  return
      '%#WarningMsg#% ┃┃ ' ..
      m[vim.api.nvim_get_mode().mode] ..
      '%=' ..
      ' %#DiagnosticError#%   ' .. #vim.diagnostic.get(0, { severity = 'Error' }) ..
      ' %#DiagnosticWarn#%  ' .. #vim.diagnostic.get(0, { severity = 'Warn' }) ..
      ' %#DiagnosticHint#%  ' .. #vim.diagnostic.get(0, { severity = 'Hint' }) ..
      ' %#Statusline#%  %l:%c' ..
      ' %#PreProc#%   ' .. "%{get(b:,'gitsigns_head','none')} " ..
      ' %#WarningMsg#% ' .. vim.loop.os_uname().sysname .. ' ┃┃'
end

autocmd({ 'BufEnter', 'WinEnter' }, {
  callback = function()
    vim.cmd('setlocal statusline=%!v:lua.Statusline()')
  end
})
