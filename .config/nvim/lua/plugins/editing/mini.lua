return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    -- Auto pairs (replaces nvim-autopairs)
    require('mini.pairs').setup()

    -- Surround operations (replaces nvim-surround)
    -- sa = add surrounding, sd = delete surrounding, sr = replace surrounding
    require('mini.surround').setup({
      mappings = {
        add = 'sa',
        delete = 'sd',
        replace = 'sr',
        find = 'sf',
        find_left = 'sF',
        highlight = 'sh',
        update_n_lines = 'sn',
      },
    })

    -- Extended text objects (new capability)
    -- Adds text objects like: af/if (function), ac/ic (class), aa/ia (argument)
    require('mini.ai').setup({
      n_lines = 500,
      custom_textobjects = {
        -- Function
        f = require('mini.ai').gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
        -- Class
        c = require('mini.ai').gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }),
      },
    })
  end,
}
