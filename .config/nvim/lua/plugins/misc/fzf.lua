return {
  'junegunn/fzf.vim',
  requires = {
    {'junegunn/fzf'}
  },
  setup = function()
    vim.api.nvim_set_keymap('n', '<Leader>t', ':Gitfiles<CR>', { noremap = true })
    vim.api.nvim_set_keymap('n', '<Leader>f', ':Files<CR>', { noremap = true })
    vim.api.nvim_set_keymap('n', '<Leader>b', ':Buffers<CR>', { noremap = true })
    vim.api.nvim_set_keymap('n', '<Leader>m', ':Marks<CR>', { noremap = true })
    vim.cmd [[command! -nargs=* F Rg <args>]]
  end,
}
