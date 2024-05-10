return {
  'JoosepAlviste/nvim-ts-context-commentstring',
  requires = {'nvim-treesitter/nvim-treesitter'},
  config = function()
    require('ts_context_commentstring').setup {}
  end
}
