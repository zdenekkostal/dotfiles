return {
  'mfussenegger/nvim-lint',
  opts = {},
  config = function()
    require('lint').linters_by_ft = {
      javascript = {'eslint_d'},
      typescript = {'eslint_d'},
      typescriptreact = {'eslint_d'},
      python = {'ruff'},
      rust = {'ruff'},
      go = {'golangcilint'},
      -- yaml = {'yamllint'},
      shell = { "shellcheck" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })

    vim.diagnostic.config({
      virtual_text = true,  -- Enable virtual text
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "󰅚 ",
          [vim.diagnostic.severity.WARN] = "󰀪 ",
          [vim.diagnostic.severity.INFO] = " ",
          [vim.diagnostic.severity.HINT] = "󰌶 ",
        }
      },
      update_in_insert = false,  -- Don't update diagnostics while typing
      underline = true,  -- Underline problematic code
      severity_sort = true,  -- Sort by severity
    })
  end,
}
