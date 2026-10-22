-- vim-tmux-navigator stays for tmux; herdr-nvim-nav handles herdr and
-- delegates to vim-tmux-navigator when nvim runs under tmux (auto-detected).
return {
  'christoomey/vim-tmux-navigator',
  {
    'aimdevlee/herdr-nvim-nav',
    dependencies = { 'christoomey/vim-tmux-navigator' },
    config = function()
      require('herdr-nvim-nav').setup()
    end,
  },
}
