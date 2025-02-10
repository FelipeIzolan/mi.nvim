--- LAZY
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
    'b0o/schemastore.nvim',
    'neovim/nvim-lspconfig',
    'nvim-tree/nvim-web-devicons',
    'SirVer/ultisnips',
    'honza/vim-snippets',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    {
      'lewis6991/gitsigns.nvim',
      config = true
    },
    {
      'quangnguyen30192/cmp-nvim-ultisnips',
      config = true
    },
    {
      'williamboman/mason.nvim',
      config = true
    },
    {
      'nvim-tree/nvim-tree.lua',
      config = true
    },
    {
      'ellisonleao/gruvbox.nvim',
      opts = {
        overrides = {
          SignColumn = { bg = "#282828" },
          DiagnosticSignError = { link = 'DiagnosticError' },
          DiagnosticSignWarn = { link = 'DiagnosticWarn'},
          DiagnosticSignHint = { link = 'DiagnosticHint' }
        }
      }
    },
    {
      'hrsh7th/nvim-cmp',
      config = function()
        local m = require 'cmp_nvim_ultisnips.mappings'
        local c = require 'cmp'
        c.setup({
          snippet = {
            expand = function(a)
              vim.fn['UltiSnips#Anon'](a.body)
            end,
          },
          mapping = {
            ['<Tab>'] = c.mapping.select_next_item(),
            ['<S-Tab>'] = c.mapping.select_prev_item(),
            ['<CR>'] = c.mapping.confirm({ select = false }),
            ['<C-up>'] = function(fallback)
              m.expand_or_jump_forwards(fallback)
            end
          },
          sources = c.config.sources({
            { name = 'ultisnips' },
            { name = 'nvim_lsp' },
            { name = 'buffer' }
          })
        })
      end
    },
    {
      'nvim-treesitter/nvim-treesitter',
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
      'williamboman/mason-lspconfig.nvim',
      config = function()
        local l = require 'lspconfig'
        local m = require 'cmp_nvim_lsp'.default_capabilities()
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

--- NEOVIM
local g = vim.g
local o = vim.opt
local keymap = vim.api.nvim_set_keymap
local autocmd = vim.api.nvim_create_autocmd

g.mapleader = ' '

o.mouse = 'a'
o.signcolumn = 'yes:1'
o.laststatus = 3
o.timeoutlen = 500
o.number = true
o.numberwidth = 1
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2
o.ignorecase = true
o.smartcase = true
o.termguicolors = true
o.clipboard = 'unnamedplus'

vim.cmd 'colorscheme gruvbox'

keymap('v', '<C-w>', ':m \'<-2<CR>gv=gv', {})
keymap('v', '<C-s>', ':m \'>+1<CR>gv=gv', {})
keymap('n', '<Leader>q', ':q<CR>', {})
keymap('n', '<Leader>w', ':belowright split +term<CR>', {})
keymap('n', '<Leader>T', ':NvimTreeClose<CR>', {})
keymap('n', '<Leader>t', '', {
  callback = function()
    local t = require 'nvim-tree.api'.tree
    if t.is_visible() then
      t.focus()
    else
      t.open()
    end
  end
})
keymap('', '<Leader>c', '', {
  callback = function()
    local cs = vim.bo.commentstring
    local md = vim.api.nvim_get_mode().mode

    if cs == '' then
      return
    end

    local function comment(l)
      return l == '' and l or cs:format(l)
    end

    local function uncomment(l)
      local tcs = cs:gsub('[%-+]', '%%-')
          :gsub('[%*+]', '%%*')
          :gsub('%%s', '(.+)')

      local c = l:match(tcs)
      l = c and l:gsub(tcs, c) or nil

      return l
    end

    if md == 'n' then
      local l = vim.api.nvim_get_current_line()
      l = uncomment(l) or comment(l)
      vim.api.nvim_set_current_line(l)
    end

    if md == 'v' then
      local s, e = vim.fn.line('v'), vim.fn.line('.')
      if s > e then
        s, e = e, s
      end
      local ls = vim.api.nvim_buf_get_lines(0, s - 1, e, true)
      for i, l in ipairs(ls) do
        ls[i] = uncomment(l) or comment(l)
      end
      vim.api.nvim_buf_set_lines(0, s - 1, e, true, ls)
    end
  end
})
local hidden = false
keymap('', '<Leader>d', '', {
  callback = function ()
    if hidden then
      vim.diagnostic.show()
    else
      vim.diagnostic.hide()
    end
    hidden = not hidden
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
         '%#Search#%  ' .. m[vim.api.nvim_get_mode().mode] ..
         ' %#Cursor#%  ' .. ' ' .. "%{get(b:,'gitsigns_head','none')}" ..
         ' %#DiagnosticError#%  󰝤 ' .. #vim.diagnostic.get(0, { severity = 'Error' }) ..
         ' %#DiagnosticWarn#% 󰝤 ' .. #vim.diagnostic.get(0, { severity = 'Warn' }) ..
         ' %#DiagnosticHint#% 󰝤 ' .. #vim.diagnostic.get(0, { severity = 'Hint' }) ..
         '%#Comment#%  ' .. '%F' ..
         '%=' ..
         ' %#Cursor#%  ' .. '%l:%c' ..
         ' %#Search#%  '.. vim.bo.filetype .. ' '
end
autocmd({ 'BufEnter', 'WinEnter' }, {
  callback = function ()
    vim.cmd('setlocal statusline=%!v:lua.Statusline()')
  end
})
autocmd({ 'TermOpen' }, {
  callback = function ()
    vim.wo.number = false
    vim.wo.signcolumn = 'no'
  end
})
