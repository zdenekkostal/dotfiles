return {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('nvim-tree').setup({
      respect_buf_cwd = true,
      sync_root_with_cwd = true,
      view = {
        width = 35,
        side = 'left',
      },
      renderer = {
        group_empty = true,
        icons = {
          show = {
            git = true,
            folder = true,
            file = true,
            folder_arrow = true,
          },
        },
      },
      filters = {
        dotfiles = false,
        custom = { '.git', 'node_modules', '.cache' },
      },
      git = {
        enable = true,
        ignore = false,
      },
      actions = {
        open_file = {
          quit_on_open = false,
          resize_window = true,
        },
      },
    })
  end,
  keys = {
    { '<leader>nt', '<cmd>NvimTreeToggle<cr>', desc = 'Toggle file tree' },
    { '<leader>nf', '<cmd>NvimTreeFindFile<cr>', desc = 'Find current file in tree' },
  },
}
