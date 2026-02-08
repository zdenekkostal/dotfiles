return {
  "greggh/claude-code.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for git operations
  },
  keys = {
    { "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Claude code" },
  },
  config = function()
    require("claude-code").setup()
  end,
}
