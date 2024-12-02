return {
  -- Treesitter support and related plugins
  require('plugins/treesitter'),
  require('plugins/treesitter/context'),
  require('plugins/treesitter/commentstring'),
  require('plugins/treesitter/rainbow-brackets'),
  require('plugins/treesitter/textobjects'),
  require('plugins/treesitter/textsubjects'),
  require('plugins/treesitter/refactor'),

  -- Git
  require('plugins/git/conflict'),
  require('plugins/git/signs'),
  require('plugins/git/fugitive'),
  require('plugins/git/diffview'),

  -- -- Editing
  require('plugins/editing/editorconfig'),
  -- require('plugins/editing/trailing-whitespace'),
  require('plugins/editing/brackets'),
  require('plugins/editing/visual-expand-region'),
  require('plugins/editing/auto-pairs'),
  require('plugins/editing/comments'),
  require('plugins/editing/search_and_replace'),
  require('plugins/editing/linting'),
  require('plugins/editing/formatting'),
  -- require('plugins/editing/lightspeed'),

  -- UI
  require('plugins/ui/lualine'),
  require('plugins/ui/filetree'),
  require('plugins/ui/marks'),
  require('plugins/ui/undotree'),
  -- -- require('plugins/ui/indent-lines'),

  -- Misc
  require('plugins/misc/aerial'),
  require('plugins/misc/sessions'),
  require('plugins/misc/telescope'),
  require('plugins/misc/zk-nvim'),
  require('plugins/misc/glow'),
  require('plugins/misc/zen-mode'),
  require('plugins/misc/linker'),
  require('plugins/misc/neotest'),
  require('plugins/misc/which-key'),

  -- Tmux
  require('plugins/tmux/navigation'),

  -- Theming
  require('plugins/themes/rose-pine'),
  -- require('plugins/themes/gruvbox'),
  -- require('plugins/themes/lighthaus'),
  -- require('plugins/themes/material'),
  -- require('plugins/themes/kanagawa'),

  -- LSP
  require('plugins/lsp'),
  require('plugins/lsp/lsp-signature'),
  require('plugins/lsp/copilot'),

  -- require('plugins/autocomplete'),
  require('plugins/autocomplete/blink'),

  -- DAP
  require('plugins/dap'),
  require('plugins/dap/ui'),

  -- AI
  require('plugins/ai/avante'),

}
