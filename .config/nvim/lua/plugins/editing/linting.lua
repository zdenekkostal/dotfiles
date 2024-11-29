return {
  'mfussenegger/nvim-lint',
  opts = {},
  config = function()
    require('lint').linters_by_ft = {
      javascript = {'eslint_d'},
      typescript = {'eslint_d'},
      python = {'ruff'},
      rust = {'ruff'},
      go = {'golangcilint'},
      yaml = {'yamllint'},
      shell = { "shellcheck" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })

    local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
  end,
}
