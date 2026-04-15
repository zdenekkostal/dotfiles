return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    -- nvim-treesitter (new version) is a parser/query manager.
    -- Neovim 0.12+ handles highlighting and indentation natively.

    -- Ensure the plugin's bundled queries are discoverable
    local ts_path = vim.fn.stdpath('data') .. '/lazy/nvim-treesitter'
    local runtime_path = ts_path .. '/runtime'
    if vim.uv.fs_stat(runtime_path) and not vim.o.runtimepath:find('nvim%-treesitter/runtime') then
      vim.opt.runtimepath:prepend(runtime_path)
    end

    require('nvim-treesitter.config').setup({})

    -- Install parsers if missing
    local ensure_installed = {
      "awk", "bash", "comment", "css", "csv", "diff", "dockerfile",
      "elixir", "git_config", "git_rebase", "gitattributes", "gitcommit",
      "gitignore", "go", "gomod", "gosum", "graphql", "html", "javascript",
      "jq", "jsdoc", "json", "lua", "luadoc", "make", "mermaid", "php",
      "phpdoc", "python", "regex", "ruby", "rust", "sql", "terraform",
      "toml", "typescript", "vim", "vimdoc", "xml", "yaml",
    }

    local installed = require('nvim-treesitter.config').get_installed()
    local to_install = vim.tbl_filter(function(lang)
      return not vim.list_contains(installed, lang)
    end, ensure_installed)

    if #to_install > 0 then
      require('nvim-treesitter.install').install(to_install, { summary = true })
    end

    -- Enable treesitter highlighting for all filetypes (Neovim 0.12+ native)
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })

    -- Textobjects
    require('nvim-treesitter-textobjects').setup({
      select = {
        lookahead = true,
        selection_modes = {
          ['@parameter.outer'] = 'v',
          ['@function.outer'] = 'V',
          ['@class.outer'] = '<c-v>',
        },
        include_surrounding_whitespace = true,
      },
      move = {
        set_jumps = true,
      },
    })

    local select = require('nvim-treesitter-textobjects.select')
    vim.keymap.set({ "x", "o" }, "af", function() select.select_textobject("@function.outer") end)
    vim.keymap.set({ "x", "o" }, "if", function() select.select_textobject("@function.inner") end)
    vim.keymap.set({ "x", "o" }, "ac", function() select.select_textobject("@class.outer") end)
    vim.keymap.set({ "x", "o" }, "ic", function() select.select_textobject("@class.inner") end)

    local move = require('nvim-treesitter-textobjects.move')
    vim.keymap.set({ "n", "x", "o" }, "]m", function() move.goto_next_start("@function.outer") end)
    vim.keymap.set({ "n", "x", "o" }, "]]", function() move.goto_next_start("@class.outer") end)
    vim.keymap.set({ "n", "x", "o" }, "]M", function() move.goto_next_end("@function.outer") end)
    vim.keymap.set({ "n", "x", "o" }, "][", function() move.goto_next_end("@class.outer") end)
    vim.keymap.set({ "n", "x", "o" }, "[m", function() move.goto_previous_start("@function.outer") end)
    vim.keymap.set({ "n", "x", "o" }, "[[", function() move.goto_previous_start("@class.outer") end)
    vim.keymap.set({ "n", "x", "o" }, "[M", function() move.goto_previous_end("@function.outer") end)
    vim.keymap.set({ "n", "x", "o" }, "[]", function() move.goto_previous_end("@class.outer") end)

    local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
    vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
  end
}
