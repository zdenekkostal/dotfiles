return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('gitsigns').setup({
      current_line_blame_opts = {
        delay = 300,
      },
    })
  end,
  keys = {
    { '<leader>gb', '<cmd>Gitsigns blame_line<cr>', desc = '[g]it [b]lame line' },
    { '<leader>gB', '<cmd>Gitsigns toggle_current_line_blame<cr>', desc = '[g]it toggle inline [B]lame' },
    { '<leader>hs', '<cmd>Gitsigns stage_hunk<cr>', desc = '[h]unk [s]tage' },
    { '<leader>hr', '<cmd>Gitsigns reset_hunk<cr>', desc = '[h]unk [r]eset' },
    { '<leader>hS', '<cmd>Gitsigns stage_buffer<cr>', desc = '[h]unk [S]tage buffer' },
    { '<leader>hR', '<cmd>Gitsigns reset_buffer<cr>', desc = '[h]unk [R]eset buffer' },
    { '<leader>hp', '<cmd>Gitsigns preview_hunk<cr>', desc = '[h]unk [p]review' },
    { '<leader>hd', '<cmd>Gitsigns diffthis<cr>', desc = '[h]unk [d]iff this' },
    { ']h', '<cmd>Gitsigns next_hunk<cr>', desc = 'Next hunk' },
    { '[h', '<cmd>Gitsigns prev_hunk<cr>', desc = 'Prev hunk' },
  },
}
