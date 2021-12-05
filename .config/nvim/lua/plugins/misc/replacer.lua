return {
  'gabrielpoca/replacer.nvim',
  setup = function()
    vim.api.nvim_set_keymap('n', '<Leader>h', ':lua require("replacer").run()<cr>', { silent = true })
  end,
}
