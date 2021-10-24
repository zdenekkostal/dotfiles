return {
  'lukas-reineke/indent-blankline.nvim',
  config = function()
    vim.wo.colorcolumn = "99999"

    require("indent_blankline").setup {
        show_end_of_line = true,
        show_current_context = true
    }
  end
}
