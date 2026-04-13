return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    current_line_blame_opts = {
      delay = 300,
    },
  },
  keys = {
    -- Navigation
    { ']h', '<cmd>Gitsigns next_hunk<cr>', desc = 'Next hunk' },
    { '[h', '<cmd>Gitsigns prev_hunk<cr>', desc = 'Prev hunk' },

    -- Hunk actions
    { '<leader>hs', '<cmd>Gitsigns stage_hunk<cr>', desc = '[h]unk [s]tage' },
    { '<leader>hs', ':Gitsigns stage_hunk<cr>', mode = 'v', desc = '[h]unk [s]tage' },
    { '<leader>hr', '<cmd>Gitsigns reset_hunk<cr>', desc = '[h]unk [r]eset' },
    { '<leader>hr', ':Gitsigns reset_hunk<cr>', mode = 'v', desc = '[h]unk [r]eset' },
    { '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<cr>', desc = '[h]unk [u]ndo stage' },
    { '<leader>hS', '<cmd>Gitsigns stage_buffer<cr>', desc = '[h]unk [S]tage buffer' },
    { '<leader>hR', '<cmd>Gitsigns reset_buffer<cr>', desc = '[h]unk [R]eset buffer' },
    { '<leader>hp', '<cmd>Gitsigns preview_hunk<cr>', desc = '[h]unk [p]review' },
    { '<leader>hP', '<cmd>Gitsigns preview_hunk_inline<cr>', desc = '[h]unk [P]review inline' },

    -- Diff this
    { '<leader>hd', '<cmd>Gitsigns diffthis<cr>', desc = '[h]unk [d]iff this' },
    { '<leader>hD', function() require('gitsigns').diffthis('~') end, desc = '[h]unk [D]iff against ~' },

    -- Blame
    { '<leader>gb', '<cmd>Gitsigns blame_line<cr>', desc = '[g]it [b]lame line' },
    { '<leader>gB', '<cmd>Gitsigns toggle_current_line_blame<cr>', desc = '[g]it toggle inline [B]lame' },

    -- Visual toggles (in-buffer visualization)
    { '<leader>hvw', '<cmd>Gitsigns toggle_word_diff<cr>', desc = '[h]unk [v]iew [w]ord diff' },
    { '<leader>hvl', '<cmd>Gitsigns toggle_linehl<cr>', desc = '[h]unk [v]iew [l]ine highlight' },
    { '<leader>hvd', '<cmd>Gitsigns toggle_deleted<cr>', desc = '[h]unk [v]iew [d]eleted' },
    { '<leader>hvs', '<cmd>Gitsigns toggle_signs<cr>', desc = '[h]unk [v]iew [s]igns' },

    -- Text object for hunks (use in visual/operator mode)
    { 'ih', ':<c-u>Gitsigns select_hunk<cr>', mode = { 'o', 'x' }, desc = 'inner hunk' },
  },
}
