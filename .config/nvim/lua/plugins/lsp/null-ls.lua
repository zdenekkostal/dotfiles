return {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = {
    {'plenary.nvim'}
  },
  config = function()
    local null_ls = require('null-ls')

    local lsp_formatting = function(bufnr)
        vim.lsp.buf.format({
            filter = function(client)
                return client.name == "null-ls"
            end,
            bufnr = bufnr,
        })
    end

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    local on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    lsp_formatting(bufnr)
                end,
            })
        end
    end

    null_ls.setup({
      sources = {
        -- JS/TS
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.diagnostics.eslint_d,

        -- Go
        null_ls.builtins.formatting.gofumpt,
        null_ls.builtins.diagnostics.golangci_lint,

        -- Rust
        null_ls.builtins.formatting.rustfmt,

        -- Python
        null_ls.builtins.formatting.ruff,
        null_ls.builtins.diagnostics.ruff,

        -- Yaml
        null_ls.builtins.formatting.yamlfmt,
        null_ls.builtins.diagnostics.yamllint,

        -- Shell
        null_ls.builtins.diagnostics.shellcheck,

        -- Markdown
        null_ls.builtins.diagnostics.markdownlint,
      },
      on_attach = on_attach
    })
  end
}
