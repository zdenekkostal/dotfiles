-- TODO bootstrap packer
-- TODO wrap plenary with something
-- require('plenary.reload').reload_module('plugins')

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

require('plugins')
