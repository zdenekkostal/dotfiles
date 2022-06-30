return {
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup({
      highlight = {
        enable = true,
        use_language_tree = true,
      },
      indent = {
        enable = true
      }
    })
  end
}
