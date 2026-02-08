return {
  'stevearc/conform.nvim',
  opts = {},
  config = function()
    require("conform").formatters.gci = {
      prepend_args = function(self, ctx)
        local origin_url = vim.fn.systemlist("git config --get remote.origin.url")
        local user_repo = origin_url[1]:match(":([^%.]+)%.git$")
        return { "-s", "standard", "-s", "default", "-s", "prefix(github.com/" .. user_repo .. ")" }
      end,
    }

    require("conform").setup({
      formatters_by_ft = {
        go = { "gofumpt", "gci" },
        python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
        rust = { "rustfmt", lsp_format = "fallback" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "markdownlint" },
        shell = { "shellcheck" },
        terraform = { "terraform-fmt" },
        yaml = { "yamlfmt" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    })
  end,
}
