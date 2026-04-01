return {
  "stevearc/aerial.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("aerial").setup()
  end,
  keys = {
    { "<leader>os", "<cmd>AerialToggle!<cr>", desc = "[o]utline [s]ymbols" },
    { "{", "<cmd>AerialPrev<cr>", desc = "Aerial prev symbol" },
    { "}", "<cmd>AerialNext<cr>", desc = "Aerial next symbol" },
  },
}
