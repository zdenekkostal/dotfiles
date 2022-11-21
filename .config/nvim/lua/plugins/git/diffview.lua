return {
  'sindrets/diffview.nvim',
  requires = {
    'nvim-lua/plenary.nvim'
  },
  cmd = {'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory'},
  setup = function()
    vim.api.nvim_set_keymap('n', '<Leader>dio', ':DiffviewOpen<CR>', { noremap = false })
    vim.api.nvim_set_keymap('n', '<Leader>dic', ':DiffviewClose<CR>', { noremap = false })
  end
}
