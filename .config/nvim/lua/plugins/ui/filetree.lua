return {
  'kyazdani42/nvim-tree.lua',
  requires = {
    {'kyazdani42/nvim-web-devicons', opt = true},
  },
  cmd = {'NvimTreeToggle', 'NvimTreeFindFile'},
  setup = function()
    vim.api.nvim_set_keymap('n', '<Leader>nt', ':NvimTreeToggle<CR>', { noremap = true })
    vim.api.nvim_set_keymap('n', '<Leader>nf', ':NvimTreeFindFile<CR>', { noremap = true })
  end,
  config = function()
    require'nvim-tree'.setup({
      filters = {
        custom = {'.git'}
      }
    })
  end
}
