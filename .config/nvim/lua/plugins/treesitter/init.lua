return {
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = 'maintained',
      highlight = {
        enable = true,
        use_language_tree = true,
      },
      indent = {
        enable = true
      }
    })

    vim.api.nvim_set_option('foldmethod', 'expr')
    vim.api.nvim_set_option('foldexpr', 'nvim_treesitter#foldexpr()')
  end
}
