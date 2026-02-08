return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
    'ibhagwan/fzf-lua',
  },
  cmd = 'Neogit',
  keys = {
    { '<leader>gs', '<cmd>Neogit kind=split<cr>', desc = 'Neogit (split)' },
    { '<leader>gc', '<cmd>Neogit commit<cr>', desc = 'Neogit commit' },
    { '<leader>gp', '<cmd>Neogit push<cr>', desc = 'Neogit push' },
    { '<leader>gl', '<cmd>Neogit log<cr>', desc = 'Neogit log' },
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
