return {
  'pablopunk/pi.nvim',
  config = function()
    require('pi').setup({
      provider = 'anthropic',
      model = 'claude-sonnet-4-5',
    })
  end,
  keys = {
    { '<leader>pi', '<cmd>PiAsk<cr>', desc = '[p]i ask' },
    { '<leader>pi', '<cmd>PiAskSelection<cr>', mode = 'v', desc = '[p]i ask selection' },
    { '<leader>pl', '<cmd>PiLog<cr>', desc = '[p]i [l]og' },
  },
}
