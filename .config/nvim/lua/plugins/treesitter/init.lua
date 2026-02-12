return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        "awk",
        "bash",
        "comment",
        "css",
        "csv",
        "diff",
        "dockerfile",
        "elixir",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "graphql",
        "html",
        "javascript",
        "jq",
        "jsdoc",
        "json",
        "lua",
        "luadoc",
        "make",
        "mermaid",
        "php",
        "phpdoc",
        "python",
        "regex",
        "ruby",
        "rust",
        "sql",
        "terraform",
        "toml",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
      auto_install = true,
      highlight = {
        enable = true,
        use_language_tree = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true
      },
      -- incremental_selection = {
      --   enable = true,
      --   keymaps = {
      --     -- init_selection = "v",
      --     node_incremental = "v",
      --     node_decremental = "V",
      --   },
      -- },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
          },
          selection_modes = {
            ['@parameter.outer'] = 'v',
            ['@function.outer'] = 'V',
            ['@class.outer'] = '<c-v>',
          },
          include_surrounding_whitespace = true,
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = { query = "@class.outer", desc = "Next class start" },
            ["]o"] = "@loop.*",
            ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
            ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
          goto_next = {
            ["]d"] = "@conditional.outer",
          },
          goto_previous = {
            ["[d"] = "@conditional.outer",
          }
        },
        lsp_interop = {
          enable = true,
          border = 'none',
          floating_preview_opts = {},
          peek_definition_code = {
            ["<leader>df"] = "@function.outer",
            ["<leader>dF"] = "@class.outer",
          },
        },
      },
    })

    local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

    vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
    vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
    vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
    vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
  end
}
