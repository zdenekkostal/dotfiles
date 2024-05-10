return {
  "stevearc/aerial.nvim",
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
  config = function()
    require("aerial").setup()

    vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
  end,
}
