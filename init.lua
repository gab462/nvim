vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.hlsearch = false
vim.o.mouse = ""
vim.o.guicursor = ""
vim.o.guifont = "Iosevka SS04 Medium Extended:h24"

vim.g.netrw_banner = 0

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

local lazy = require('lazy')

lazy.setup({
  spec = {
      {
          'neovim/nvim-lspconfig',
          config = function()
              vim.lsp.config('zuban', {
                  cmd = function(dispatchers)
                      return vim.lsp.rpc.start({
                          vim.fn.getcwd() .. '/.venv/bin/zuban', 'server'
                      }, dispatchers)
                  end,
                  filetypes = { 'python' },
                  root_markers = { 'pyproject.toml' }
              })

              vim.lsp.enable('zuban')
          end
      },
      {
          'nvim-telescope/telescope.nvim',
          dependencies = { 'nvim-lua/plenary.nvim' },
          keys = {
              { '<C-p>', function() require('telescope.builtin').git_files() end, remap = false }
          }
      },
      {
          'saghen/blink.cmp',
          opts = {
              keymap = { preset = 'super-tab' },
              fuzzy = { implementation = 'lua' },
              signature = { enabled = true }
          }
      },
      {
          'NeogitOrg/neogit',
          dependencies = { 'nvim-lua/plenary.nvim' },
          cmd = 'Neogit'
      },
      {
          'nvim-orgmode/orgmode',
          ft = 'org',
          opts = {
              org_agenda_files = "~/org/**/*",
              org_default_notes_file = "~/org/refile.org"
          }
      }
  },
  checker = { enabled = true }
})
