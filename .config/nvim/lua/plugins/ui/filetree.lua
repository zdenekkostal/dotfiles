return {
  'kyazdani42/nvim-tree.lua',
  requires = {
    'kyazdani42/nvim-web-devicons',
  },
  config = function()
    vim.api.nvim_set_keymap('n', '<Leader>nt', ':NvimTreeToggle<CR>', { noremap = true })
    vim.api.nvim_set_keymap('n', '<Leader>nf', ':NvimTreeFindFile<CR>', { noremap = true })
    vim.g.nvim_tree_ignore = {'.git'}
  end
}
