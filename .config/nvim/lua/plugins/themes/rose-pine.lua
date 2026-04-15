return {
  'rose-pine/neovim',
  lazy = false,
  priority = 1000,
  name = 'rose-pine',
  config = function()
    require('rose-pine').setup({
      dark_variant = 'main',
    })
  end,
}
