return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
    'ibhagwan/fzf-lua',
  },
  cmd = 'Neogit',
  keys = {
    { '<leader>gg', '<cmd>Neogit kind=split<cr>', desc = '[g]it neo[g]it' },
    { '<leader>gc', '<cmd>Neogit commit<cr>', desc = '[g]it [c]ommit' },
    { '<leader>gP', '<cmd>Neogit push<cr>', desc = '[g]it [P]ush' },
  },
  opts = {
    -- Neogit settings
    kind = 'split', -- opens neogit in a split
    commit_editor = {
      kind = 'split',
    },
    popup = {
      kind = 'split',
    },
    signs = {
      -- { CLOSED, OPENED }
      hunk = { '', '' },
      item = { '>', 'v' },
      section = { '>', 'v' },
    },
    integrations = {
      diffview = true,
      fzf_lua = true,
    },
  },
}
