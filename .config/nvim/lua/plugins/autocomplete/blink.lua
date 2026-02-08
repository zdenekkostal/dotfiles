return {
  'saghen/blink.cmp',
  lazy = false,
  dependencies = {
    'rafamadriz/friendly-snippets'
  },

  version = '1.*', -- Use stable releases
  -- build = 'cargo build --release', -- Uncomment if building from source

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'enter',
      ['<Tab>'] = { 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
    },

    appearance = {
      nerd_font_variant = 'normal',
    },

    sources = {
      default = { 'lsp', 'codecompanion', 'snippets', 'buffer', 'path' },
      providers = {
        codecompanion = {
          name = 'CodeCompanion',
          module = 'codecompanion.providers.completion.blink',
        },
      },
    },

    completion = {
      accept = { 
        auto_brackets = { enabled = true },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
      },
    },

    signature = { 
      enabled = true,
    },
  },
  
  opts_extend = { 'sources.default' },
}
