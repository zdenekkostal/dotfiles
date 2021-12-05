return {
  'sindrets/diffview.nvim',
  cmd = {'DiffviewOpen', 'DiffviewClose'},
  setup = function()
    vim.api.nvim_set_keymap('n', '<Leader>dio', ':DiffviewOpen<CR>', { noremap = false })
    vim.api.nvim_set_keymap('n', '<Leader>dic', ':DiffviewClose<CR>', { noremap = false })
  end
}
