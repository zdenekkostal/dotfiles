return {
  'tpope/vim-fugitive',
  opt = true,
  cmd = 'Git',
  setup = function()
    vim.api.nvim_set_keymap('n', '<Leader>g', ':Git blame<CR>', { noremap = true })
  end
}
