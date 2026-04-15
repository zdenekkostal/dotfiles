return {
  'coder/claudecode.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('claudecode').setup({
      terminal = {
        split_side = 'right',
        split_width_percentage = 0.4,
        provider = 'native',
      },
    })
  end,
  keys = {
    { '<leader>cc', '<cmd>ClaudeCode<cr>', desc = '[c]laude [c]ode toggle' },
    { '<leader>cf', '<cmd>ClaudeCodeFocus<cr>', desc = '[c]laude code [f]ocus' },
    { '<leader>cs', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = '[c]laude code [s]end selection' },
    { '<leader>ca', '<cmd>ClaudeCodeAdd %<cr>', desc = '[c]laude code [a]dd file' },
    { '<leader>co', '<cmd>ClaudeCodeOpen<cr>', desc = '[c]laude code [o]pen' },
  },
}
