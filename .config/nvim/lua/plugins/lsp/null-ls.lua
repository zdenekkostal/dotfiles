return {
  'jose-elias-alvarez/null-ls.nvim',
  requires = {
    {'plenary.nvim'}
  },
  config = function()
    local null_ls = require('null-ls')

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.diagnostics.markdownlint,
      },
      on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
            vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
        end
      end,
    })
  end
}
