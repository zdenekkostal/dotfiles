return {
  'ibhagwan/fzf-lua',
  config = function()
    local fzf = require('fzf-lua')
    local actions = require('fzf-lua.actions')

    fzf.setup({
      'max-perf',
      fzf_colors = true, -- inherit colors from FzfLua* highlight groups
      winopts = {
        height = 0.80,
        width = 0.80,
        border = 'rounded',
        backdrop = 100,
        preview = {
          border = 'border',
          layout = 'vertical',
          vertical = 'down:45%',
          winopts = { number = false },
        },
      },
      git = {
        status = {
          actions = {
            ['ctrl-s'] = { fn = actions.git_stage_unstage, reload = true },
            ['ctrl-x'] = { fn = actions.git_reset, reload = true },
          },
        },
      },
    })

    fzf.register_ui_select()
  end,
  keys = {
    { "<leader>ff", function() require('fzf-lua').files() end, desc = "[f]ind [f]iles" },
    { "<leader>fp", function() require('fzf-lua').git_files() end, desc = "[f]ind [p]roject files" },
    { "<leader>fg", function() require('fzf-lua').live_grep() end, desc = "[f]ind [g]rep" },
    { "<leader>fs", function() require('fzf-lua').grep_cword() end, desc = "[f]ind [s]tring" },
    { "<leader>fb", function() require('fzf-lua').buffers() end, desc = "[f]ind [b]uffers" },
    { "<leader>fo", function() require('fzf-lua').oldfiles() end, desc = "[f]ind [o]ld files" },
    { "<leader>fh", function() require('fzf-lua').help_tags() end, desc = "[f]ind [h]elp" },
    { "<leader>fm", function() require('fzf-lua').marks() end, desc = "[f]ind [m]arks" },
    { "<leader>flr", function() require('fzf-lua').lsp_references() end, desc = "[f]ind [l]sp [r]eferences" },
    { "<leader>fli", function() require('fzf-lua').lsp_implementations() end, desc = "[f]ind [l]sp [i]mplementations" },
    { "<leader>fld", function() require('fzf-lua').lsp_definitions() end, desc = "[f]ind [l]sp [d]efinitions" },
    -- Git pickers
    { "<leader>fgs", function() require('fzf-lua').git_status() end, desc = "[f]ind [g]it [s]tatus" },
    { "<leader>fgc", function() require('fzf-lua').git_commits() end, desc = "[f]ind [g]it [c]ommits" },
    { "<leader>fgb", function() require('fzf-lua').git_branches() end, desc = "[f]ind [g]it [b]ranches" },
    -- GitHub
    { "<leader>ghi", function() require('fzf-lua').gh_issues() end, desc = "[g]it[h]ub [i]ssues" },
    { "<leader>ghp", function() require('fzf-lua').gh_prs() end, desc = "[g]it[h]ub [p]ull requests" },
  },
}
