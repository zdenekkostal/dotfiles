local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.o.foldmethod = 'expr'
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- OSC 52 clipboard support for SSH sessions only
if vim.env.SSH_TTY then
  vim.g.clipboard = {
    name = 'osc52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
      ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
      ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
      ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
    },
  }
end

vim.opt.clipboard = 'unnamedplus'

-- File watcher for external agent modifications (Claude Code, etc.)
-- Automatically reloads buffers when files are changed externally
local function setup_file_watcher()
  local group = vim.api.nvim_create_augroup('ExternalFileSync', { clear = true })

  vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'TermLeave' }, {
    group = group,
    callback = function()
      if vim.o.buftype ~= 'nofile' then
        vim.cmd('checktime')
      end
    end,
  })

  vim.api.nvim_create_autocmd('FileChangedShellPost', {
    group = group,
    callback = function()
      vim.notify('File changed on disk. Buffer reloaded.', vim.log.levels.INFO)
    end,
  })
end

setup_file_watcher()

require("lazy").setup(require('plugins'), opts)
