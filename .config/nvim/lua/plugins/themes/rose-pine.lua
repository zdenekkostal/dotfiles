return {
  'rose-pine/neovim',
  lazy = false,
  priority = 1000,
  name = 'rose-pine',
  config = function()
    require('rose-pine').setup({
      --- @usage 'auto'|'main'|'moon'|'dawn'
      variant = 'auto',
      --- @usage 'main'|'moon'|'dawn'
      dark_variant = 'main',

      -- groups = {
      --   border = "NONE",
      -- },

      -- highlight_groups = {
      --   VertSplit = { fg = "NONE", bg = "NONE" },
      -- }
    })

    -- Load colorscheme after options
    vim.cmd('colorscheme rose-pine')
  end
}
