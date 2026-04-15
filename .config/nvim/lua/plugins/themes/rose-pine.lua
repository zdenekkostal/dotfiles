return {
  'rose-pine/neovim',
  lazy = false,
  priority = 1000,
  name = 'rose-pine',
  config = function()
    require('rose-pine').setup({
      dark_variant = 'main',
      palette = {
        dawn = {
          base = "#f2e9e1",    -- warmer background matching ghostty theme
          surface = "#ede4dc",
        },
      },
      highlight_groups = {
        -- Give function calls a visible color (rose) instead of inheriting text
        ["@function.call"]        = { fg = "rose" },
        ["@function.method.call"] = { fg = "rose" },

        -- Make modules stand out from regular variables
        ["@module"]               = { fg = "iris" },

        -- Bold types for better structure visibility
        ["@type"]                 = { fg = "foam", bold = true },
        ["@constructor"]          = { fg = "foam", bold = true },
      },
    })
  end,
}
