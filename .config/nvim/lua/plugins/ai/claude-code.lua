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
    { '<leader>ac', '<cmd>ClaudeCodeToggle<cr>', desc = 'Toggle Claude Code terminal' },
    { '<leader>af', '<cmd>ClaudeCodeFocus<cr>', desc = 'Focus Claude Code terminal' },
    { '<leader>as', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = 'Send selection to Claude' },
    { '<leader>aa', '<cmd>ClaudeCodeAdd %<cr>', desc = 'Add current file to Claude context' },
    { '<leader>ao', '<cmd>ClaudeCodeOpen<cr>', desc = 'Open Claude Code' },
  },
}
