return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    -- explorer = { enabled = true },
    gh = { enabled = true },
    indent = {
      enabled = true,
      animate = {
        enabled = false,
      },
    },
    input = { enabled = true },
    -- picker disabled: using fzf-lua for better performance
    notifier = { enabled = true },
    scratch = { enabled = true },
    -- quickfile = { enabled = true },
    -- scope = { enabled = true },
    -- scroll = { enabled = true },
    -- statuscolumn = { enabled = true },
    -- words = { enabled = true },
    --
  },
  keys = {
    { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
  }
}
