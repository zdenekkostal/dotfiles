return {
  'ibhagwan/fzf-lua',
  config = function()
    local fzf = require('fzf-lua')
    
    fzf.setup({
      'max-perf'
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
  },
}
