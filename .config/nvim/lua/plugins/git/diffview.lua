return {
  'sindrets/diffview.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim'
  },
  keys = {
    { "<leader>dio", "<cmd>DiffviewOpen<cr>", desc = "DiffviewOpen" },
    { "<leader>dic", "<cmd>DiffviewClose<cr>", desc = "DiffviewClose" },
  }
}
