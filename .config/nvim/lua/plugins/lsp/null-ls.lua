return {
  'jose-elias-alvarez/null-ls.nvim',
  requires = {
    {'neovim/nvim-lspconfig'},
    {'plenary.nvim'}
  },
  config = function()
    local null_ls = require('null-ls')

    null_ls.config({
      sources = {
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.diagnostics.markdownlint,
      },
    })

    require('lspconfig')['null-ls'].setup({
      on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
          vim.api.nvim_command [[augroup Format]]
          vim.api.nvim_command [[autocmd! * <buffer>]]
          vim.api.nvim_command [[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()]]
          vim.api.nvim_command [[augroup END]]
        end
      end
    })
  end
}
