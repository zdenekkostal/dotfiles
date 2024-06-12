return {
  'sourcegraph/sg.nvim',
  requires = {
    {'nvim-lua/plenary.nvim'},
    {'nvim-telescope/telescope.nvim'},
  },
  config = function()
    require("sg").setup({
      enable_cody = true
    })

    vim.keymap.set('n', '<leader>ss', require('sg.extensions.telescope').fuzzy_search_results, {})
  end
}
