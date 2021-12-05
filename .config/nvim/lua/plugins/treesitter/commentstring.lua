return {
  'JoosepAlviste/nvim-ts-context-commentstring',
  requires = {'nvim-treesitter/nvim-treesitter'},
  config = function()
    require('nvim-treesitter.configs').setup({
      context_commentstring = {
        enable = true
      }
    })
  end
}
