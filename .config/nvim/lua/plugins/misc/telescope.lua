return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    {'nvim-lua/plenary.nvim'},
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
    {
      'nvim-telescope/telescope-ui-select.nvim'
    }
  },
  config = function()
    local builtin = require('telescope.builtin')
    local actions = require('telescope.actions')

    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fs', builtin.grep_string, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    vim.keymap.set('n', '<leader>fm', builtin.marks, {})
    vim.keymap.set('n', '<leader>flr', builtin.lsp_references, {})
    vim.keymap.set('n', '<leader>fli', builtin.lsp_implementations, {})
    vim.keymap.set('n', '<leader>fld', builtin.lsp_definitions, {})

    require("telescope").setup({
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({})
        }
      },
      defaults = {
          mappings = {
              i = {
                  ["<C-j>"] = actions.move_selection_next,
                  ["<C-k>"] = actions.move_selection_previous
              }
          }
      }
    })

    require('telescope').load_extension('fzf')
    require('telescope').load_extension('ui-select')
  end,
}
