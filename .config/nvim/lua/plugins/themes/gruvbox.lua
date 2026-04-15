return {
  'ellisonleao/gruvbox.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('gruvbox').setup({
      contrast = 'medium',
      transparent_mode = false,
      overrides = {
        -- Treesitter: give variables and modules some color
        ["@variable"]           = { link = "GruvboxFg1" },
        ["@variable.member"]    = { link = "GruvboxAqua" },
        ["@variable.parameter"] = { link = "GruvboxBlue" },
        ["@module"]             = { link = "GruvboxAqua" },
        ["@property"]           = { link = "GruvboxAqua" },
        ["@function.call"]      = { link = "GruvboxGreenBold" },
        ["@function.method.call"] = { link = "GruvboxGreenBold" },
        ["@type"]               = { link = "GruvboxYellow" },
        ["@type.builtin"]       = { link = "GruvboxYellowBold" },
        ["@constructor"]        = { link = "GruvboxYellow" },

        -- fzf-lua picker: solid gruvbox background instead of white
        FzfLuaNormal        = { link = "NormalFloat" },
        FzfLuaBorder        = { link = "FloatBorder" },
        FzfLuaTitle         = { link = "FloatTitle" },
        FzfLuaPreviewNormal = { link = "NormalFloat" },
        FzfLuaPreviewBorder = { link = "FloatBorder" },
        FzfLuaPreviewTitle  = { link = "FloatTitle" },
        FzfLuaCursorLine    = { link = "CursorLine" },
        FzfLuaSearch        = { link = "IncSearch" },
        FzfLuaHeaderText    = { link = "Comment" },
        FzfLuaFzfNormal     = { link = "NormalFloat" },
        FzfLuaFzfCursorLine = { link = "CursorLine" },
        FzfLuaFzfMatch      = { link = "Special" },
      },
    })
  end,
}
