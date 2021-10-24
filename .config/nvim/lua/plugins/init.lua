require('packer').startup({
  {
    require('plugins/packer'),

    -- Treesitter support and related plugins
    require('plugins/treesitter'),
    require('plugins/treesitter/completion'),
    require('plugins/treesitter/commentstring'),
    require('plugins/treesitter/rainbow-brackets'),

    -- Git
    require('plugins/git/signs'),
    require('plugins/git/fugitive'),

    -- Editing
    require('plugins/editing/editorconfig'),
    require('plugins/editing/trailing-whitespace'),
    require('plugins/editing/brackets'),
    require('plugins/editing/visual-expand-region'),
    require('plugins/editing/auto-pairs'),
    require('plugins/editing/comments'),
    require('plugins/editing/goyo'),

    -- UI
    require('plugins/ui/lualine'),
    require('plugins/ui/filetree'),
    require('plugins/ui/marks'),
    require('plugins/ui/undotree'),
    require('plugins/ui/indent-lines'),

    -- Misc
    require('plugins/misc/sessions'),
    require('plugins/misc/fzf'),

    -- Tmux
    require('plugins/tmux/navigation'),

    -- Theming
    require('plugins/themes/gruvbox'),

    -- LSP
    require('plugins/lsp'),
    require('plugins/autocomplete'),
  }
})
